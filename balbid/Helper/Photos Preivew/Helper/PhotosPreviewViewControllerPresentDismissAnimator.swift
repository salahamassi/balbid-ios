//
//  PhotosPreviewViewControllerPresentDismissAnimator.swift
//  MSA
//
//  Created by Salah Amassi on 4/8/20.
//  Copyright © 2020 MSA. All rights reserved.
//

import UIKit
import VICMAImageView

// just confirm this protocol to any view has a media to preview, i prefer to to apply it to parent view of media view, cause maybe in futuer i want to animate the parent too.
public protocol HasMediaToPreview {
    
    var mediaView: UIImageView { get }
    
}

public class PhotosPreviewViewControllerPresentDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate{
    
    var transitionDuration: Double
    public var mediaContainerView: HasMediaToPreview?
    var isPresent: Bool = true
    
    override init(){ transitionDuration = 0.4 }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration 
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresent{
            animatePresentTransition(using: transitionContext)
        }else{
            animateDismissTransition(using: transitionContext)
        }
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionDuration = 0.4
        isPresent = true
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionDuration = 0.4
        isPresent = false
        return self
    }
    
    func animatePresentTransition(using transitionContext: UIViewControllerContextTransitioning){
        guard
            let toViewController = transitionContext.viewController(forKey: .to) as? PhotosPreviewViewController,
            let fromView = transitionContext.viewController(forKey: .from)?.view, // bug in ios 13 
            let toView = transitionContext.view(forKey: .to),
            let mediaContainerView = mediaContainerView,
            let startFrame = mediaContainerView.mediaView.superview?.convert(mediaContainerView.mediaView.frame, to: nil)
            else { return }
        mediaContainerView.mediaView.alpha = 0
        
        toViewController.customView.blackMaskView.alpha = 0
        toView.frame = fromView.frame
        
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let newHeight = (screenWidth / startFrame.width) * screenHeight
        let newY = screenHeight / 2 - newHeight / 2
        
        let fakeImageView = VICMAImageView()
        fakeImageView.image = mediaContainerView.mediaView.image
        fakeImageView.contentMode = .scaleAspectFill
        fakeImageView.clipsToBounds = true
        
        toView.addSubview(fakeImageView)
        
        fakeImageView
            .withFrame(startFrame)
            .withCornerRadius(8, corners:[.topRight, .bottomLeft, .bottomRight])
        
        toView.bringSubviewToFront(fakeImageView)
        
        
        UIView.animate(withDuration: transitionDuration , delay: 0, options: .curveEaseInOut, animations: {
            fakeImageView.contentMode = .scaleAspectFit
            fakeImageView
                .withFrame(CGRect(x: 0, y: newY, width: screenWidth, height: newHeight))
                .withCornerRadius(0)
            toViewController.customView.blackMaskView.alpha = 1
        }) { (bool) in
            transitionContext.completeTransition(true)
            fakeImageView.removeFromSuperview()
            toViewController.toogleViews()
        }
    }
    
    func animateDismissTransition(using transitionContext: UIViewControllerContextTransitioning){
        guard
            let fromViewController = transitionContext.viewController(forKey: .from) as? PhotosPreviewViewController,
            let fromView = transitionContext.view(forKey: .from),
            let mediaContainerView = mediaContainerView,
            let startFrame = mediaContainerView.mediaView.superview?.convert(mediaContainerView.mediaView.frame, to: fromView)
            else { return }
        
        fromViewController.toogleViews()
        
        let fakeImageView = VICMAImageView()
        fakeImageView.image = mediaContainerView.mediaView.image
        fakeImageView.contentMode = .scaleAspectFit
        fakeImageView.clipsToBounds = true
        
        fakeImageView.frame = fromView.frame
        
        
        fromView.addSubview(fakeImageView)
        
        UIView.animate(withDuration: transitionDuration , delay: 0, options: .curveEaseInOut, animations: {
            fakeImageView.contentMode = .scaleAspectFill
            fakeImageView
                .withFrame(startFrame)
                .withCornerRadius(8, corners:  [.topRight, .bottomLeft, .bottomRight])
            fromViewController.customView.blackMaskView.alpha = 0
        }) { (bool) in
            mediaContainerView.mediaView.alpha = 1
            transitionContext.completeTransition(true)
            fakeImageView.removeFromSuperview()
        }
    }
}
