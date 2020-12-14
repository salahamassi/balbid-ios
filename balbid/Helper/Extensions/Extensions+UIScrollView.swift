//
//  Extensions+UIScrollView.swift
//  MSA
//
//  Created by Salah Amassi on 4/8/20.
//  Copyright © 2020 MSA. All rights reserved.
//

import UIKit

extension UIScrollView{
        
    @discardableResult
    func withDelegate(_ delegate: UIScrollViewDelegate) -> UIScrollView{
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    func withZoomScale(minimumZoomScale: CGFloat, maximumZoomScale: CGFloat) -> UIScrollView{
        self.minimumZoomScale = minimumZoomScale
        self.maximumZoomScale = maximumZoomScale
        return self
    }
    
    @discardableResult
    func shouldShowsVerticalScrollIndicator(_ value: Bool) -> UIScrollView{
        showsVerticalScrollIndicator = value
        return self
    }
    
    @discardableResult
    func shouldShowsHorizontalScrollIndicator(_ value: Bool) -> UIScrollView{
        showsHorizontalScrollIndicator = value
        return self
    }
    
    @discardableResult
    func alwaysBounceVertical(_ value: Bool) -> UIScrollView{
        alwaysBounceVertical = value
        return self
    }

}
