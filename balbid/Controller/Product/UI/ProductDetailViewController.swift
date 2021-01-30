//
//  ProductDetailViewController.swift
//  balbid
//
//  Created by Qamar Nahed on 03/01/2021.
//

import UIKit

class ProductDetailViewController: BaseViewController {
    
    @IBOutlet weak var smallHeaderView: UIView!
    // header view or container for header view
    @IBOutlet weak var headerView: UIView!

    // scroll view container
    @IBOutlet weak var containerView: UIView!

    // constrain the height of the headerView
    // in a more complex UI, use frame, let autolayout calculate based on subviews
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!

    // constraint between the top of headerView and the top of the screen
    @IBOutlet weak var headerViewTop: NSLayoutConstraint!

    // constraint between the top of the tableView container and the top of the screen
    // also used for the "collapsed" height of the headerView
    @IBOutlet weak var containerViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var addToCartButton: UIButton!
    
    override var mustHideNavigationBar: Bool {
        return true
    }
    // how far the header view gets scrolled offscreen
    var maxScrollAmount: CGFloat {
        let expandedHeight = headerViewHeight.constant
        let collapsedHeight = containerViewTop.constant
        return expandedHeight - collapsedHeight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupView()
    }

    private func setupScrollView() {
        if let scrollView = containerView.subviews.first as? UIScrollView {
            // adjust the scroll view's top inset to account for scrolling the header offscreen
            scrollView.contentInset = UIEdgeInsets(top: maxScrollAmount, left: 0, bottom: 0, right: 0)
        }
        
        if let scrollViewContained = children.first as? ProductDetailContentViewController {
            scrollViewContained.delegate = self
        }
    }
    
    
    private func setupView() {
        addToCartButton.withCornerRadius(12, corners: [.topLeft,.topRight])
    }

}
// MARK:- ScrollViewContaining Delegate

extension ProductDetailViewController: ScrollViewContainingDelegate {
    func scrollView(didScroll scrollView: UIScrollView) {
        // need to adjust the content offset to account for the content inset
        // negative because we are moving the header offscreen
        let newTopConstraintConstant = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        headerViewTop.constant = min(0, max(-maxScrollAmount, newTopConstraintConstant))
        let isAtTop = headerViewTop.constant == -maxScrollAmount

        // handle changes for collapsed state
        scrollViewScrolled(scrollView, didScrollToTop: isAtTop)
    }

    func scrollViewScrolled(_ scrollView: UIScrollView, didScrollToTop isAtTop:Bool) {
        if isAtTop {
            headerView.animateIsHidden(value: true)
            smallHeaderView.animateIsHidden(value: false)
        }else{
            headerView.animateIsHidden(value: false)
            smallHeaderView.animateIsHidden(value: true)
        }
    }
    
    
    @IBAction func goBack(_ sender: Any){
        router?.popViewController()
    }
    
    
}
