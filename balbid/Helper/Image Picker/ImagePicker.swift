//
//  ImagePicker.swift
//  MSA
//
//  Created by Salah Amassi on 10/24/20.
//  Copyright © 2020 msa. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import CropViewController
 
class ImagePickerHelper: NSObject{
    
    private weak var viewController: UIViewController?
    private weak var router: AppRouter?
    var completion: ((_ url: [URL]) -> Void)?
    var imageCompletion: ((_ image: UIImage) -> Void)?
    var didStartCamera: (() -> Void)?

    
    var didPresentPicker: (() -> Void)?
    var didDismissPicker: (() -> Void)?


    private let imagePicker = UIImagePickerController()
    private let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.composite-content"], in: .import)
    private var mustCropImage = false
    
    
    init(viewController: UIViewController, router: AppRouter?) {
        self.viewController = viewController
        self.router = router
        super.init()
    }
    
    func displayImagePickerAlertActionSheet(with view: UIView, mustAddDeleteAction: Bool = false, mustAddChooseFromDocumentAction: Bool = false, mustCropImage: Bool = false, mustUseAppPicker: Bool = false, winchPickerMaxSelection: Int? = nil, deleteCompletion: (()->Void)? = nil){
        guard let viewController = viewController else { return }
        self.mustCropImage = mustCropImage
        viewController.displayImagePickerAlertActionSheet(with: view,completion: { (selectedAction) in
            switch selectedAction{
            case .takePicture:
                self.checkCameraAuthorizationStatus()
            case .chooseFromGallery:
                self.checkPhotoAuthorizationStatus(mustUseWinchPicker: mustUseAppPicker, winchPickerMaxSelection: winchPickerMaxSelection)
            case .delete:
                deleteCompletion?()
            case .chooseFromDocument:
                viewController.present(self.documentPicker, animated: true, completion: nil)
            }
        }, mustAddDeleteAction: mustAddDeleteAction, mustAddChooseFromDocumentAction: mustAddChooseFromDocumentAction)
    }
    
    func checkCameraAuthorizationStatus() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized:
            DispatchQueue.main.async {
                self.presentCameraImagePickre()
            }
        case .denied:
            DispatchQueue.main.async {
                self.displayCameraAccessDeniedAlert()
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                DispatchQueue.main.async {
                    if success {
                        self.presentCameraImagePickre()
                    } else {
                        self.displayCameraAccessDeniedAlert()
                    }
                }
            }
        default: break
        }
    }
    
    private func checkPhotoAuthorizationStatus(mustUseWinchPicker: Bool, winchPickerMaxSelection: Int? = nil) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            DispatchQueue.main.async {
                if mustUseWinchPicker{
                    var params: [String: Any] = ["delegate": self]
                    if let maxSelection = winchPickerMaxSelection{
                        params["maxSelection"] = maxSelection
                    }
                    self.router?.navigate(to: .photosPicker(params: params), completion: {
                        self.didPresentPicker?()
                    })
                }else{
                    self.presentPhotoImagePickre()
                }
            }
        case .denied, .restricted, .limited:
            DispatchQueue.main.async {
                self.displayPhotosAccessDeniedAlert()
            }
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                self.checkPhotoAuthorizationStatus(mustUseWinchPicker: mustUseWinchPicker)
            }
        @unknown default:
            fatalError("unkown authorization status")
        }
    }
    
    private func presentCameraImagePickre(){
        guard let viewController = viewController else { return }
        imagePicker.sourceType = .camera
        imagePicker.cameraCaptureMode = .photo
        imagePicker.cameraFlashMode = .off
        imagePicker.delegate = self
        viewController.present(imagePicker, animated: true, completion: {
            self.didPresentPicker?()
        })
        didStartCamera?()
    }
    
    private func presentPhotoImagePickre(){
        guard let viewController = viewController else { return }
        imagePicker.allowsEditing = !mustCropImage
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        viewController.present(imagePicker, animated: true, completion: {
            self.didPresentPicker?()
        })
    }
    
    private func displayCameraAccessDeniedAlert() {
        guard let viewController = viewController else { return }
        let title = "keyword.alert".localized
        let message = "alert.message.cameraAccess".localized
        let defaultButtonTitle = "alert.action.title.goToSetting".localized
        viewController.displayAlert(title: title, message: message, defaultButtonTitle: defaultButtonTitle, destructiveButtonTitle: nil) {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
    }
    
    private func displayPhotosAccessDeniedAlert() {
        guard let viewController = viewController else { return }
        let title = "keyword.alert".localized
        let message = "alert.message.photoAccess".localized
        let defaultButtonTitle = "alert.action.title.goToSetting".localized
        viewController.displayAlert(title: title, message: message, defaultButtonTitle: defaultButtonTitle, destructiveButtonTitle: nil) {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
    }
    
}

extension ImagePickerHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            picker.dismiss(animated: true, completion: nil)
            guard let viewController = viewController else { return }
            if mustCropImage{
                let cropViewController = CropViewController(image: pickedImage)
                cropViewController.delegate = self
                viewController.present(cropViewController, animated: true, completion: nil)
            }else{
                guard let pickedImageURL = pickedImage.jpeg(.medium)?.saveImage() else { return  }
                completion?([pickedImageURL])
                imageCompletion?(pickedImage)
            }
        }else if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            guard let _ = viewController else { return }
            if mustCropImage{
                let cropViewController = CropViewController(image: pickedImage)
                cropViewController.delegate = self
                picker.present(cropViewController, animated: true, completion: nil)
            }else{
                picker.dismiss(animated: true, completion: nil)
                guard let image = pickedImage.jpeg(.medium) else { return  }
                guard let pickedImageURL = image.saveImage() else { return  }
                completion?([pickedImageURL])
                imageCompletion?(pickedImage)
            }
        }
    }
    
}

extension ImagePickerHelper: PhotosCollectionViewControllerDelegate{
    
    func photosCollectionViewController(_ picker: PhotosCollectionViewController, didFinishPicking urls: [URL], images: [UIImage]) {
        if images.count == 1{
            guard let image =  images.first else { return }
            let cropViewController = CropViewController(image: image)
            cropViewController.delegate = self
            picker.present(cropViewController, animated: true, completion: nil)
        }else if images.count > 1{
            picker.dismiss(animated: true, completion: {
                self.didDismissPicker?()
            })
            completion?(urls)
        }
    }
    
}

extension ImagePickerHelper: CropViewControllerDelegate{
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int){
        viewController?.dismiss(animated: true, completion: nil)
        guard let url = image.jpeg(.medium)?.saveImage() else { return  }
        completion?([url])
        imageCompletion?(image)
    }
    
}

extension ImagePickerHelper: UIDocumentPickerDelegate{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        completion?([url])
    }
}
