//
//  ProductDetailHeaderCollectionReusableView.swift
//  balbid
//
//  Created by Memo Amassi on 28/01/2021.
//

import UIKit

class ProductDetailHeaderCollectionReusableView: UICollectionReusableView {
    public var animator: UIViewPropertyAnimator?

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "detail-sample-image")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetUp()
    }
    
    private func viewSetUp() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
            ])
        arrangeView()
        addBlurVisulaEffectView()
    }
    
    
    private func arrangeView(){
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.alignment = .fill
        mainStackView.spacing = 41
        
        //First item Horizontal Stack View
        let firstItemStackView = UIStackView()
        firstItemStackView.axis = .horizontal
        firstItemStackView.distribution = .equalSpacing
        
        let backButton = UIButton(image: #imageLiteral(resourceName: "round_arrow_back_ios_black_24pt").withRenderingMode(.alwaysOriginal))
        let searchButton = UIButton(image: #imageLiteral(resourceName: "search"))
        searchButton.tintColor = .black
        firstItemStackView.addArrangedSubview(backButton)
        firstItemStackView.addArrangedSubview(searchButton)
        
        mainStackView.addArrangedSubview(firstItemStackView)
        
        
        //second item internal Stack View
        let scondryStackView = UIStackView()
        scondryStackView.axis = .vertical
        scondryStackView.distribution = .fill
        scondryStackView.alignment = .leading
        scondryStackView.spacing = 13
        mainStackView.addArrangedSubview(scondryStackView)

       //third item favorite
        let favoriteButton = UIButton(image: #imageLiteral(resourceName: "empty-star").withRenderingMode(.alwaysOriginal))
        favoriteButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.39)
        scondryStackView.addArrangedSubview(favoriteButton)
        
        favoriteButton.constrainWidth(27)
        favoriteButton.constrainHeight(27)
        favoriteButton.cornerRadius = 27/2
        
        
        //fourth item share
        let shareButton = UIButton(image : #imageLiteral(resourceName: "share").withRenderingMode(.alwaysOriginal))
         shareButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.39)
        scondryStackView.addArrangedSubview(shareButton)
        
        shareButton.constrainWidth(27)
        shareButton.constrainHeight(27)
        shareButton.cornerRadius = 27/2
        
        imageView.addSubview(mainStackView)

        mainStackView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 24, left: 16, bottom: 0, right: 16))

        

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

}
