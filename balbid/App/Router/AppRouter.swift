//
//  AppRouter.swift
//  balbid
//
//  Created by Salah Amassi on 13/12/2020.
//

import UIKit

protocol Route {
    
    var modalPresentationStyle: UIModalPresentationStyle { get }
    var animatedTransitioningDelegate: UIViewControllerTransitioningDelegate? { get }
    var navigateType: NavigateType { get }
    
    func create(_ router: AppRouter, _ params: [String: Any]?) -> UIViewController
    
}

enum NavigateType{
    case present, push, pushFromBottom, windowRoot
}

class AppRouter{
    
    let window: UIWindow

    var currentViewController: UIViewController?

    
    init(window: UIWindow, rootViewController: UIViewController? = nil) {
        self.window = window
        if let rootViewController = rootViewController{
            window.rootViewController = rootViewController
            window.makeKeyAndVisible()
            currentViewController = rootViewController
        }
    }
    
    func navigate(to route: Route, with params: [String: Any]?, completion: (() -> Void)?){
        let view = route.create(self, params)
        if let currentViewController = currentViewController {
            if type(of: view) == type(of: currentViewController) {
                print(type(of: view))
                print(type(of: currentViewController))
                return
            }
        }
        if route.navigateType == .push{
            guard let rootViewController = window.rootViewController else { return }
            if rootViewController is UINavigationController{
                (rootViewController as! UINavigationController).pushViewController(view, animated: true)
            }else{
                if !(window.rootViewController?.children.last is UINavigationController) { return }
                precondition(window.rootViewController?.children.last is UINavigationController)
                (rootViewController.children.last as! UINavigationController).pushViewController(view, animated: true)
            }
            completion?()
        }else if route.navigateType == .pushFromBottom{
            pushViewControllerFromBottom(view)
            completion?()
        } else if route.navigateType == .present{
            guard let rootViewController = window.rootViewController else { return }
            view.modalPresentationStyle = route.modalPresentationStyle
            view.transitioningDelegate = route.animatedTransitioningDelegate
            if let rootViewController = rootViewController.presentedViewController{
                rootViewController.present(view, animated: true, completion: completion)
            }else{
                rootViewController.present(view, animated: true, completion: completion)
            }
        }else{
            window.rootViewController = view
            window.makeKeyAndVisible()
            let options: UIView.AnimationOptions = .transitionCrossDissolve

            // The duration of the transition animation, measured in seconds.
            let duration: TimeInterval = 0.8

            // Creates a transition animation.
            // Though `animations` is optional, the documentation tells us that it must not be nil. ¯\_(ツ)_/¯
            UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
            { completed in
                completion?()
            })

        }
        currentViewController = view
    }
    
    func navigate(to viewController: UIViewController){
        
    }
    
    func popViewController(){
        guard let rootViewController = window.rootViewController else { return }
        if rootViewController is UINavigationController{
            (rootViewController as! UINavigationController).popViewController(animated: true)

        }else{
            precondition(window.rootViewController?.children.last is UINavigationController)
            (rootViewController.children.last as! UINavigationController).popViewController(animated: true)
        }
        currentViewController = nil
    }
    
    func popToRootViewController(){
        guard let rootViewController = window.rootViewController else { return }
        if rootViewController is UINavigationController{
            (rootViewController as! UINavigationController).popToRootViewController(animated: true)
        }else{
            if !(window.rootViewController?.children.first is UINavigationController) { return }
            precondition(window.rootViewController?.children.first is UINavigationController)
            (rootViewController.children.first as! UINavigationController).popToRootViewController(animated: true)
        }
        currentViewController = nil
    }

    func pop(numberOfScreens: Int){
        guard let rootViewController = window.rootViewController else { return }
        let navigationController: UINavigationController
        if rootViewController is UINavigationController{
            navigationController = (window.rootViewController as! UINavigationController)
         }else{
            if !(window.rootViewController?.children.first is UINavigationController) { return }
            precondition(window.rootViewController?.children.first is UINavigationController)
            navigationController = window.rootViewController?.children.first as! UINavigationController
        }
        precondition(numberOfScreens + 1 <= navigationController.viewControllers.count)
        navigationController.popToViewController(navigationController.viewControllers[navigationController.viewControllers.count - (numberOfScreens + 1)], animated: true)
        currentViewController = nil
    }
    
    func remove(numberOfScreens: Int){
        guard let rootViewController = window.rootViewController else { return }
        let navigationController: UINavigationController
        if rootViewController is UINavigationController{
            navigationController = (window.rootViewController as! UINavigationController)
         }else{
            if !(window.rootViewController?.children.first is UINavigationController) { return }
            precondition(window.rootViewController?.children.first is UINavigationController)
            navigationController = window.rootViewController?.children.first as! UINavigationController
        }
        precondition(numberOfScreens + 1 <= navigationController.viewControllers.count)
        navigationController.viewControllers.removeSubrange(1...numberOfScreens)
        currentViewController = nil
    }
    
    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil){
        window.rootViewController?.presentedViewController?.dismiss(animated: animated, completion: completion)
        currentViewController = window.rootViewController
    }
    
   private func pushViewControllerFromBottom(_ viewController: UIViewController) {
        guard let rootViewController = window.rootViewController else { return }
        let navigationController: UINavigationController
        if rootViewController is UINavigationController{
            navigationController = (window.rootViewController as! UINavigationController)
         }else{
            if !(window.rootViewController?.children.first is UINavigationController) { return }
            precondition(window.rootViewController?.children.first is UINavigationController)
            navigationController = window.rootViewController?.children.first as! UINavigationController
        }
        let transition = CATransition()
        transition.duration = 0.30
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .moveIn
        transition.subtype = .fromTop
        navigationController.view.layer.add(transition, forKey: kCATransition)
        navigationController.pushViewController(viewController, animated: false)
        currentViewController = viewController
    }
    
   func popViewControllerFromTop() {
        guard let rootViewController = window.rootViewController else { return }
        let navigationController: UINavigationController
        if rootViewController is UINavigationController{
            navigationController = (window.rootViewController as! UINavigationController)
         }else{
            if !(window.rootViewController?.children.first is UINavigationController) { return }
            precondition(window.rootViewController?.children.first is UINavigationController)
            navigationController = window.rootViewController?.children.first as! UINavigationController
        }
        let transition = CATransition()
        transition.duration = 0.30
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .reveal
        transition.subtype = .fromBottom
        navigationController.view.layer.add(transition, forKey: kCATransition)
        navigationController.popViewController(animated: false)
        currentViewController = nil
    }
    
    func removeAllAndKeep(types: [AnyClass]){
        guard let rootViewController = window.rootViewController else { return }
        let navigationController: UINavigationController
        if rootViewController is UINavigationController{
            navigationController = (window.rootViewController as! UINavigationController)
         }else{
            if !(window.rootViewController?.children.first is UINavigationController) { return }
            precondition(window.rootViewController?.children.first is UINavigationController)
            navigationController = window.rootViewController?.children.first as! UINavigationController
        }
        var viewControllers = navigationController.viewControllers
        viewControllers.removeAll { (viewController) -> Bool in
            let viewControllerType = type(of: viewController)
            return !types.contains(where: { (type) -> Bool in
                viewControllerType == type
            })
        }
        navigationController.setViewControllers(viewControllers, animated: true)
        currentViewController = nil
    }
    
    func remove(types: [AnyClass]){
        guard let rootViewController = window.rootViewController else { return }
        let navigationController: UINavigationController
        if rootViewController is UINavigationController{
            navigationController = (window.rootViewController as! UINavigationController)
         }else{
            if !(window.rootViewController?.children.first is UINavigationController) { return }
            precondition(window.rootViewController?.children.first is UINavigationController)
            navigationController = window.rootViewController?.children.first as! UINavigationController
        }
        var viewControllers = navigationController.viewControllers
        viewControllers.removeAll { (viewController) -> Bool in
            let viewControllerType = type(of: viewController)
            return types.contains(where: { (type) -> Bool in
                viewControllerType == type
            })
        }
        navigationController.setViewControllers(viewControllers, animated: true)
        currentViewController = nil
    }

}
