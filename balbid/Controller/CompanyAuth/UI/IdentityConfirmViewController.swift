//
//  IdentityConfirmViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 23/12/2020.
//

import UIKit
import SDWebImage

class IdentityConfirmViewController: BaseViewController {

    var imagePickerHelper: ImagePickerHelper?
    @IBOutlet var pickedImages: [UIImageView]!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePicker()
        sortPickedImage()

        // Do any additional setup after loading the view.
    }

    private func setupImagePicker() {
        imagePickerHelper = ImagePickerHelper.init(viewController: self, router: router)
    }

    private func sortPickedImage() {
        pickedImages = pickedImages.sorted {$0.tag < $1.tag}
    }

    @IBAction func toggleAgree(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.backgroundColor = UIColor.appColor(.primaryColor)
            sender.setImage(UIImage(named: .checkImage), for: .normal)
            sender.tag = 1
        } else {
            sender.backgroundColor = UIColor.appColor(.lightGrayColor)
            sender.setImage(nil, for: .normal)
            sender.tag = 0
        }
    }

    @IBAction func pickImage(_ sender: UIButton) {
        imagePickerHelper?.displayImagePickerAlertActionSheet(with: sender, mustAddChooseFromDocumentAction: true, mustCropImage: true)
        imagePickerHelper?.completion = .some({[weak self] (urls) in
            let icon = urls[0].lastPathComponent.getFileIconFromName()
            if icon == nil {
                self?.pickedImages[sender.tag].sd_setImage(with: urls[0], completed: nil)
            } else {
                self?.pickedImages[sender.tag].image = UIImage(named: "icon")
            }
        })

    }

}
