//
//  AddToCartBottomSheet.swift
//  balbid
//
//  Created by Qamar Nahed on 03/01/2021.
//

import UIKit

class AddToCartBottomSheet: BottomSheetView {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!

    var addProductsToCart: ((_  total: String) -> Void)?
    var failedToAdd: ((_ message: String) -> Void)?
    var product: ProductItem? {
        didSet {
            priceLabel.text = product!.price + " SAR"
        }
    }
    private var quantity: Int = 1
    private var viewModel: AddToCartViewModel!


    override class func initFromNib() -> AddToCartBottomSheet {
        return Bundle.init(for: AddToCartBottomSheet.self).loadNibNamed(.addToCartView, owner: self, options: nil)!.first as! AddToCartBottomSheet
    }
    
    override func awakeFromNib() {
        viewHeight = 159
        super.awakeFromNib()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel = AddToCartViewModel(dataSource: AppDataSource())
        viewModel.delegate = self
    }
    
    @IBAction func addToCart(_ sender: Any) {
        guard let product = product else {
            return
        }
        addToCartButton.loadingIndicator(true)
        viewModel.addToCart(productId: product.id, qunatity: quantity, total: priceLabel.text!)
//        addProductsToCart?()
    }
    
    @IBAction func changeQuantity(_ sender: UIButton) {
        if sender.tag == 0 {
            quantity += 1
        }else {
            if quantity > 1 {
                quantity -= 1
            }
        }
        quantityLabel.text = "\(quantity)"
        guard let productPrice = Double(product?.price ?? "0.0") else {
            return
        }
        priceLabel.text = "\(productPrice * Double(quantity)) SAR"
    }

}


extension AddToCartBottomSheet: AddToCartViewModelDelegate {
    func didAddSuccess(total: String) {
        quantity = 1
        quantityLabel.text = "1"
        addToCartButton.loadingIndicator(false)
        addProductsToCart?(total)
    }
    
    func apiError(error: String) {
        addToCartButton.loadingIndicator(false)
        failedToAdd?(error)
    }
    
    
    
}
