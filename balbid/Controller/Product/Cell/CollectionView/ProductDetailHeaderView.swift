//
//  ProductDetailHeaderCollectionReusableView.swift
//  balbid
//
//  Created by Memo Amassi on 28/01/2021.
//

import UIKit

class ProductDetailHeaderView: UICollectionReusableView {
    
    public var animator: UIViewPropertyAnimator?
    weak var delegate: ProductDetailHeaderCollectionReusableViewDelegate?
    private var viewModel = ProductDetailHeaderViewModel(dataSource: AppDataSource())
    
    var images: [String] = [] {
        didSet  {
            productImageCollectionViewDataSource.images  =  images
            imageCollectionView.reloadData()
        }
    }
    
    var product: ProductItem? {
        didSet {
            arrangeView()
        }
    }
    
    lazy var imageCollectionView: UICollectionView = {
        let itemSize = frame.size
        let collectionView = UICollectionView(scrollDirection: .horizontal,
                                              itemSize: itemSize,
                                              minimumInteritemSpacing: 0,
                                              minimumLineSpacing: 0,
                                              isPagingEnabled: true)
        collectionView.showsHorizontalScrollIndicator = false
        productImageCollectionViewDelegate = ProductImageCollectionViewDelegate(collectionView: collectionView)
        collectionView.delegate = productImageCollectionViewDelegate
        return collectionView
    }()
    
    private var productImageCollectionViewDataSource = ProductImageCollectionViewDataSource()
    private var productImageCollectionViewDelegate: ProductImageCollectionViewDelegate?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetUp()
        setupViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetUp()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
    }
    
    private func viewSetUp() {
        addView(imageCollectionView, anchors: .fillSuperview(.zero))
        setupCollectionView()
        addBlurVisulaEffectView()
    }
    
    private func setupCollectionView(){
        imageCollectionView.register(cells: (nibName: .productImageCell, cellId: .productImageCellId))
        imageCollectionView.dataSource = productImageCollectionViewDataSource
        productImageCollectionViewDelegate?.didScroll = { [weak self] index in
            guard let cell = self else {
                return
            }
            self?.delegate?.ProductDetailHeaderCollectionReusableView(cell, didSliderScroll: index)
        }
     //   imageCollectionView.delegate = self
    }
    
    private func arrangeView(){
        addView(
            stack(
                hstack(
                    button(image: #imageLiteral(resourceName: "round_arrow_back_ios_black_24pt").withRenderingMode(.alwaysOriginal),
                            target: self,
                            action: #selector(back)),
                    button(image: #imageLiteral(resourceName: "search"), tintColor: .black),
                    distribution: .equalSpacing
                ),
                stack(
                    button(image: ((product?.isFavorite ?? "0" == "0" ) ? #imageLiteral(resourceName: "empty-star").withRenderingMode(.alwaysOriginal) : #imageLiteral(resourceName: "full-rating-star").withRenderingMode(.alwaysOriginal).sd_resizedImage(with: .init(width: 20, height: 20), scaleMode: .aspectFit)), target: self,
                           action: #selector(addToFavorite))
                        .withBackgroundColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.39))
                        .withWidth(27)
                        .withHeight(27)
                        .withTintColor(UIColor.appColor(.yellowColor2) ?? .clear)
                        .withCornerRadius(27/2),
                    button(image: #imageLiteral(resourceName: "share").withRenderingMode(.alwaysOriginal))
                        .withBackgroundColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.39))
                        .withWidth(27)
                        .withHeight(27)
                        .withCornerRadius(27/2),
                    spacing: 13,
                    alignment: .leading
                ),
                spacing: 41
            ), anchors:
                .top(topAnchor, constant: 40),
                .leading(leadingAnchor, constant: 24),
                .trailing(trailingAnchor, constant: 24))
    }
    
    @objc func back(){
        delegate?.ProductDetailHeaderCollectionReusableView(self, performAction: .back)
    }
    
    @objc func addToFavorite(_ sender: UIButton){
        guard let product = product else {
            return
        }
        guard UserDefaultsManager.token != nil else {
            self.delegate?.displayLoginAlert()
            return
        }
        sender.loadingIndicator(true,indicatorColor: UIColor.appColor(.primaryColor) ?? .white)
        if ((product.isFavorite ?? "0") == "1") {
            viewModel.removeProductFromFavorite(productId: product.id) {
                sender.loadingIndicator(false)
                self.product!.isFavorite = "0"
                sender.setImage(#imageLiteral(resourceName: "empty-star").withRenderingMode(.alwaysOriginal), for: .normal)
            }
            
        }else{
            viewModel.addProductToFavorite(productId: product.id) {
                sender.loadingIndicator(false)
                self.product!.isFavorite = "1"
                sender.setImage(#imageLiteral(resourceName: "full-rating-star").withRenderingMode(.alwaysOriginal).sd_resizedImage(with: .init(width: 25, height: 25), scaleMode: .aspectFit), for: .normal)
            }
        }
        
    }
    
    
    @objc func seach(){
        delegate?.ProductDetailHeaderCollectionReusableView(self, performAction: .search)
    }
    
    // MARK:- add visual effect view
    private func addBlurVisulaEffectView() {
        animator = UIViewPropertyAnimator(duration: 4.0, curve: .easeInOut, animations: { [weak self] in
            guard let strongSelf = self else { return }
            
            let blurEffect = UIBlurEffect(style: .regular)
            let visulaEffectView = UIVisualEffectView(effect: blurEffect)
            visulaEffectView.translatesAutoresizingMaskIntoConstraints = false
            strongSelf.addSubview(visulaEffectView)
            
            NSLayoutConstraint.activate([
                visulaEffectView.topAnchor.constraint(equalTo: strongSelf.topAnchor, constant: 0),
                visulaEffectView.leadingAnchor.constraint(equalTo: strongSelf.leadingAnchor, constant: 0),
                visulaEffectView.bottomAnchor.constraint(equalTo: strongSelf.bottomAnchor, constant: 0),
                visulaEffectView.trailingAnchor.constraint(equalTo: strongSelf.trailingAnchor, constant: 0)
            ])
        })
    }
    
    enum ActionType {
        case back, search
    }
}

protocol ProductDetailHeaderCollectionReusableViewDelegate: class {
    func ProductDetailHeaderCollectionReusableView(_ cell: ProductDetailHeaderView, performAction action: ProductDetailHeaderView.ActionType)
    func ProductDetailHeaderCollectionReusableView(_ cell: ProductDetailHeaderView, didSliderScroll index: Int)
    func diplayErrorMessage(_ cell: ProductDetailHeaderView,  errorMessage: String)
    func displayLoginAlert()

}


extension ProductDetailHeaderView: ProductDetailHeaderViewModelDelegate {
    func apiError(error: String) {
        delegate?.diplayErrorMessage(self, errorMessage: error)
    }
    
    
}
