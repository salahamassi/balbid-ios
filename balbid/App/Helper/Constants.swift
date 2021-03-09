//
//  Constants.swift
//  balbid
//
//  Created by Salah Amassi on 13/12/2020.
//

import Foundation
import UIKit

enum AssetsColor: String {
    case primaryColor
    case viewBackgroundColor
    case labelColor
    case grayColor
    case accentColor
    case textGrayColor
    case whiteColor
    case lightGrayColor
    case lightGrayColor2
    case redColor
    case brownColor
    case borderGrayColor
    case blueColor
    case textBlacKColor2
    case textLightGrayColor
    case orangeColor
    case borderGrayColor2
    case borderGrayColor3
    case redColor2
    case yellowColor2
}

extension String {

    // view controller nib's name

    // nib's name's
    static let emptyView = "EmptyView"
    static let errorAlertView = "ErrorAlertView"
    static let confirmAlertView = "ConfirmAlertView"
    static let progressView = "ProgressView"
    static let productHeader = "ProductHeaderCell"
    static let productFooter = "ProductFooterCell"
    static let wholeSaleOfferHeader = "WholeSaleOfferHeaderCell"
    static let strongestOfferHeader = "StrongestOfferHeaderCell"
    static let categoryContentHeader = "CategoryContentHeaderCell"
    static let productCell = "ProductCell"
    static let addToCartView = "AddToCartView"
    static let productDetailHeaderView = "ProductDetailHeaderView"
    static let productImageCell = "ProductImageCell"
    static let addNewCardBottomSheet = "AddNewCardView"
    static let addedToCartView = "AddedToCartView"
    static let priceSeekBarView = "PriceSeekBarView"
    static let categoryFooterView = "CategoryFooter"
    static let colorSelectionView = "ColorSelectionView"
    static let colorSelectionCell = "ColorSelectionCell"

    
    
    //  cell's header's, Annotation's id's
    static let photoPreviewCellId = "photoPreviewCellId"
    static let thumbnailCellId = "thumbnailCellId"
    static let authorizePeopleCellId = "auth_people_cell"
    static let bankInformationCellId = "bank_info_cell"
    
    //home cell's id
    static let sliderCellId = "slider_cell"
    static let sliderIndicatorCellId = "slider_indicator_cell"
    static let categoryCellId = "category_cell"
    static let offerCellId = "offer_cell"
    static let pickedFeatureCellId = "picked_feature_cell"
    static let productHeaderCellId = "product_header"
    static let productCellId = "product_cell"
    static let addCellId = "ad_cell"
    static let wholesaleOffersHeaderCellId = "wholesale_offers_header"
    static let strongestOfferProductHeaderCellId = "strongest_offer_product_header"
    static let strongestOfferCellId = "strongest_offer_cell"
    static let offerAdCellId = "offer_ad_cell"
    static let productCategoryCellId = "product_category_cell"
    static let categoryContentHeaderCellId = "category_content_header"
    static let categoryContentCellId = "category_content_cell"
    static let cartCellId = "cart_cell"
    static let colorCellId = "color_cell"    
    static let rateCellId = "rate_cell"
    static let footerRateCellId = "footer_cell"
    static let pointCellId = "point_cell"
    static let orderFilterCellId = "order_filter_cell"
    static let orderHeaderCellId = "order_header_cell"
    static let orderCellId = "order_cell"
    static let favoriteCellId = "favorite_cell"
    static let productDetailHeaderCellId = "product_detail_header_cell"
    static let productDetailCellId = "product_detail_cell"
    static let productImageCellId = "product_image_cell"
    static let shippingAddressCellId = "shipping_address_cell"
    static let orderProductCellId = "order_product_cell"
    static let reorderCellId = "reorder_cell"
    static let creditBalanceCellId = "credit_balance_cell"
    static let paymentCardCellId = "payment_card_cell"
    static let productFooterCellId = "product_footer_cell"
    static let categoryProductFooterCellId = "category_product_footer"
    static let imageSliderCellId = "image_slider_cell"


    
    
    // storyboard names
    static let mainStoryboard = "Main"
    static let authStoryboard = "Auth"
    static let authComapnyStoryboard = "CompanyAuth"
    static let splashStoryboard = "Splash"
    static let categoriesStoryboard = "Categories"
    static let productStoryboard = "Product"
    static let profileStoryboard = "Profile"
    static let orderStoryboard = "Order"
    static let shippingStoryboard = "Shipping"
    static let paymentStoryboard = "Payment"
    static let createOrderStoryboard = "CreateOrder"

    // view  controller id's
    static let splashViewControllerId = "SplashViewController"
    static let loginNavigationViewControllerId = "LoginNavigationViewController"

    static let loginOptionViewControllerId = "LoginOptionViewController"
    static let accountOptionViewControllerId = "AccountOptionViewController"

    static let loginViewControllerId = "LoginViewController"
    static let registerViewControllerId = "RegisterViewController"
    static let forgetPasswordViewControllerId = "ForgetPasswordViewController"
    static let forgetPasswordCodeViewControllerId = "ForgetPasswordCodeViewController"
    static let setNewPasswordCodeViewControllerId = "SetNewPasswordViewController"

    static let authComapnyMainViewControllerId = "AuthComapnyMainViewController"
    static let companyHolderInformationViewControllerId = "CompanyHolderInformationViewController"
    static let companyInformationViewControllerId = "CompanyInformationViewController"
    static let authorizePeopleViewControllerId = "AuthorizePeopleViewController"
    static let bankInformationViewControllerId = "BankInformationViewController"
    static let identityConfirmViewControllerId = "IdentityConfirmViewController"
    static let authCompanyCreatedSuccessfullyViewControllerId = "AuthCompanyCreatedSuccessfullyViewController"

    static let mainTabBarViewControllerId = "MainTabBarViewController"
    static let adCategoriesViewController = "AdCategoriesViewController"
    static let categoriesFilterViewController = "CategoriesFilterViewController"
    static let productDetailViewController = "ProductDetailNewViewController"
    static let productDetailQuickViewViewController = "ProductDetailQuickViewViewController"
    static let productDetailRateViewController = "ProductDetailRateViewController"
    static let productRatingViewController = "ProductRatingViewController"
    static let productTraceViewController = "ProductTraceViewController"

    
    
    static let editProfileViewController = "EditProfileViewController"
    static let pointViewController = "PointViewController"
    static let favoriteViewController = "FavoriteViewController"
    
    
    static let shippingAdressViewController = "ShippingAdressViewController"
    static let OrderShippingAdressViewController = "OrderShippingAdressViewController"
    static let addNewShippingViewController = "AddNewShippingViewController"
    static let shippingMapViewController = "ShippingMapViewController"
    static let creditBalanceViewController = "CreditBalanceViewController"

    
    static let userOrderViewController = "UserOrderViewController"
    static let orderDetailViewController = "OrderDetailViewController"
    static let orderTraceMapViewController = "OrderTraceMapViewController"
    static let reorderViewController = "ReorderViewController"
    static let addedToCartViewController = "AddedToCartViewController"
    
    
    static let paymentCardViewController = "PaymentCardViewController"
    
    
    static let createOrderViewController = "CreateOrderViewController"
    
    
    // image name
    static let lockedPasswordImage = "locked_password"
    static let unlockedPasswordImage = "unlocked_password"
    static let checkImage = "right"
    static let backImage = "back"
    static let barCodeImage = "bar_code"
    static let arrowDownImage = "arrow_bottom"
    static let arrowUpImage = "arrow_top"
    static let searchImage = "search"
    static let logoImage = "nav_logo"
    static let trashImage = "trash"
    static let starImage = "star"
    static let closeImage = "close"

    
    
    //collection view header kind
    static let leadingKind = "leadingKind"
    static let topKind = "topKind"

}

extension Notification.Name {

    static let BALBIDLocationUpdated = Notification.Name("BALBIDLocationUpdated")
    static let BALBIDLocationAccessRestricted = Notification.Name("BALBIDLocationAccessRestricted")

}

 extension UIViewController {

    enum ImagePickerAction {
        case takePicture, chooseFromGallery, chooseFromDocument, delete
    }

    func displayImagePickerAlertActionSheet(with view: UIView, completion: @escaping(_ selectedAction: ImagePickerAction) -> Void, mustAddDeleteAction: Bool = false, mustAddChooseFromDocumentAction: Bool = false) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.modalPresentationStyle = .popover
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = view
            presenter.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        }
        let takePictureAlertAction = UIAlertAction(title: "alert.action.title.camera".localized, style: .default) { _ in
            completion(.takePicture)
        }

        takePictureAlertAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        takePictureAlertAction.setValue(UIImage(named: "cell2")?.withRenderingMode(.alwaysOriginal), forKey: "image")
        takePictureAlertAction.setValue(UIColor.systemBlue, forKey: "titleTextColor")

        let chooseFromGalleryAlertAction = UIAlertAction(title: "alert.action.title.gallery".localized, style: .default) {
            _ in
            completion(.chooseFromGallery)
        }
        chooseFromGalleryAlertAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        chooseFromGalleryAlertAction.setValue(UIImage(named: "cell1")?.withRenderingMode(.alwaysOriginal), forKey: "image")

        let deleteAlertAction = UIAlertAction(title: "alert.action.title.deletePhoto".localized, style: .destructive) {
            _ in
            completion(.delete)
        }
        deleteAlertAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        deleteAlertAction.setValue(UIImage(named: "ic_delete_image")?.withRenderingMode(.alwaysOriginal), forKey: "image")

        let chooseFromDocumentsAlertAction = UIAlertAction(title: "alert.action.title.documnets".localized, style: .default) { (_) in
            completion(.chooseFromDocument)
        }
        chooseFromDocumentsAlertAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        chooseFromDocumentsAlertAction.setValue(UIImage(named: "cell3")?.withRenderingMode(.alwaysTemplate), forKey: "image")
        chooseFromDocumentsAlertAction.setValue(UIColor.systemBlue, forKey: "titleTextColor")

        let canelAlertAction = UIAlertAction(title: "alert.action.title.cancel".localized, style: .cancel, handler: nil)
        canelAlertAction.setValue(UIColor.systemBlue, forKey: "titleTextColor")

        alert.addAction(takePictureAlertAction)
        alert.addAction(chooseFromGalleryAlertAction)
        if mustAddDeleteAction {
            alert.addAction(deleteAlertAction)
        }

        if mustAddChooseFromDocumentAction {
            alert.addAction(chooseFromDocumentsAlertAction)
        }

        alert.addAction(canelAlertAction)

        present(alert, animated: true, completion: nil)
    }
 }
