//
//  IdentityConfirmViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 23/12/2020.
//

import UIKit
import SDWebImage

class IdentityConfirmViewController: BaseViewController {

    private var imagePickerHelper: ImagePickerHelper?
    @IBOutlet var pickedImages: [BorderedImageView]!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var idenityImage: UIImage?
    private var commerciaRegistrationImage: UIImage?
    private var municipalityLicenseImage: UIImage?
    private var isAgreed: Bool = false
    private var viewModel = IdentityConfirmViewModel()

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
            isAgreed = true
        } else {
            sender.backgroundColor = UIColor.appColor(.lightGrayColor)
            sender.setImage(nil, for: .normal)
            sender.tag = 0
            isAgreed = false
        }
    }

    @IBAction func pickImage(_ sender: UIButton) {
        imagePickerHelper?.displayImagePickerAlertActionSheet(with: sender, mustAddChooseFromDocumentAction: true, mustCropImage: true)
    
        imagePickerHelper?.completion = .some({[weak self] (urls) in
            let icon = urls[0].lastPathComponent.getFileIconFromName()
            self?.pickedImages[sender.tag].isError = false
            if icon == nil {
                self?.pickedImages[sender.tag].sd_setImage(with: urls[0], completed: {_,_,_,_ in
                    switch sender.tag {
                    case 0:
                        self?.idenityImage = self?.pickedImages[sender.tag].image?.imageWithSize(scaledToSize: CGSize(width: 144, height: 144))
                    case 1:
                        self?.commerciaRegistrationImage = self?.pickedImages[sender.tag].image?.imageWithSize(scaledToSize: CGSize(width: 144, height: 144))
                    case 2:
                        self?.municipalityLicenseImage = self?.pickedImages[sender.tag].image?.imageWithSize(scaledToSize: CGSize(width: 144, height: 144))
                    default:
                        break
                    }
                })
            } else {
                self?.pickedImages[sender.tag].image = UIImage(named: "icon")
            }
         
        })
    
    }
    
    func validate() -> Bool {
        var isValid = true
        var error = ""
    
        if(!isAgreed) {
            isValid = false
            error = "You must accept term and condition to continue"
        }
        if(municipalityLicenseImage == nil) {
            pickedImages[2].isError = true
            isValid = false
            error = "Please upload municipality License Image"
        }
        if(commerciaRegistrationImage == nil) {
            pickedImages[1].isError = true
            isValid = false
            error = "Please upload commercial Registration image"
        }
        if(idenityImage == nil) {
            pickedImages[0].isError = true
            isValid = false
            error = "Please upload identity image"
        }
        
        if(isValid) {
            guard let idenityImageBase64 = idenityImage?.getBase64FromImage(),
                  let commerciaRegistrationImageBase64 = commerciaRegistrationImage?.getBase64FromImage(),
                  let municipalityLicenseImageBase64 = municipalityLicenseImage?.getBase64FromImage() else {
                return  false
            }
            viewModel.addField(identityImage: idenityImageBase64, commerciaRegistrationImage: commerciaRegistrationImageBase64, municipalityLicenseImage: municipalityLicenseImageBase64)
        }
        
        errorLabel.isHidden = false
        errorLabel.text = error
        return isValid
        
    }

}
