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
    case redColor
    case brownColor

}

extension String {

    // view controller nib's name

    // nib's name's
    static let emptyView = "EmptyView"
    static let errorAlertView = "ErrorAlertView"
    static let confirmAlertView = "ConfirmAlertView"
    static let progressView = "ProgressView"

    //  cell's header's, Annotation's id's
    static let photoPreviewCellId = "photoPreviewCellId"
    static let thumbnailCellId = "thumbnailCellId"
    static let authorizePeopleCellId = "auth_people_cell"
    static let bankInformationCellId = "bank_info_cell"

    // storyboard names
//    static let mainStoryboard = "Main"
    static let authStoryboard = "Auth"
    static let authComapnyStoryboard = "CompanyAuth"
    static let splashStoryboard = "Splash"

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

    
    // image name
    static let lockedPasswordImage = "locked_password"
    static let unlockedPasswordImage = "unlocked_password"
    static let checkImage = "right"
    static let backImage = "back"

    
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
