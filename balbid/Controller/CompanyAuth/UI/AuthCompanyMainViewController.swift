//
//  AuthCompanyMainViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 21/12/2020.
//

import UIKit

class AuthCompanyMainViewController: BaseViewController {

    override var mustClearNavigationBar: Bool {
         false
    }

    var step = 1

    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint?

    var progressView: ProgressView!

    @IBOutlet weak var containerView: UIView!
    
    var currentViewController: UIViewController!

    lazy var companyHolderInforamtionViewController: CompanyHolderInformationViewController = {
        let viewController =  UIStoryboard.authComapnyStoryboard.getViewController(with: .companyHolderInformationViewControllerId)  as! CompanyHolderInformationViewController
        return viewController
    }()

    lazy var companyInforamtionViewController: CompanyInformationViewController = {
        let viewController =  UIStoryboard.authComapnyStoryboard.getViewController(with: .companyInformationViewControllerId
        )  as! CompanyInformationViewController
        return viewController
    }()

    lazy var authorizePeopleViewController: AuthorizePeopleViewController = {
        let viewController =  UIStoryboard.authComapnyStoryboard.getViewController(with: .authorizePeopleViewControllerId)  as! AuthorizePeopleViewController
        viewController.delegate =  self
        return viewController
    }()
    
    lazy var bankInformationViewController: BankInformationViewController = {
        let viewController =  UIStoryboard.authComapnyStoryboard.getViewController(with: .bankInformationViewControllerId)  as! BankInformationViewController
        viewController.delegate =  self
        return viewController
    }()
    
    lazy var identityConfirmViewController: IdentityConfirmViewController = {
        let viewController =  UIStoryboard.authComapnyStoryboard.getViewController(with: .identityConfirmViewControllerId)  as! IdentityConfirmViewController
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle()
        addNavRightView()
        addNavleftView()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setContainerView()
        progressView.setupLayerShape()
        progressView.move(fromStep: 0, to: step)
    }

    func addNavRightView() {
        progressView = ProgressView.initFromNib()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: progressView )
    }

    func addNavleftView() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: .backImage), style: .plain, target: self, action: #selector(self.goBack))
    }
    
    
    func setContainerView() {
        currentViewController?.remove()
        switch step {
        case 1:
            currentViewController = companyHolderInforamtionViewController
        case 2:
            currentViewController = companyInforamtionViewController
        case 3:
            currentViewController = authorizePeopleViewController
        case 4:
            currentViewController = bankInformationViewController
        case 5:
            currentViewController = identityConfirmViewController
        default:
            currentViewController = companyHolderInforamtionViewController

        }
        containerViewHeightConstraint?.constant = currentViewController.view.subviews.first?.frame.height ?? .zero
        print(currentViewController.view.subviews.first?.frame.height ?? .zero)
        add(currentViewController, to: containerView, frame: containerView.frame)
    }
    
    @objc func goBack(){
        if  step > 1 {
            step -= 1
            setContainerView()
            setNavTitle()
            progressView.move(fromStep: step+1, to: step)
        }else{
            router?.pop(numberOfScreens: 1)
        }
    }

    func setNavTitle() {
        switch step {
        case 1:
            self.title =  "Company Holder Information"
        case 2:
            self.title =  "Company Information"
        case 3:
            self.title =  "Authorized People"
        case 4:
            self.title =  "Bank Information"
        case 5:
            self.title =  "Identity Confirm"
        default:
            self.title = "Company Holder Info"
        }

    }

    @IBAction func goToNextStep(_ sender: Any) {
        if  step < 5 {
            step += 1
            setContainerView()
            setNavTitle()
            progressView.move(fromStep: step-1, to: step)
        }else if step == 5 {
            router?.navigate(to: .authCompanyCreatedSuccessfullyRoute)
        }
    }

}

extension  AuthCompanyMainViewController: SizeChangableDelegate {
    func didUpdateContentSize(newHeight: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.containerViewHeightConstraint?.constant += newHeight
            self.view.layoutIfNeeded()
        }
    }
    
  
}
