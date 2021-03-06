//
//  WPFBannerComponents.swift
//  WPFBannerView
//
//  Created by alex on 2017/7/28.
//  Copyright © 2017年 http://codewpf.com/. All rights reserved.
//

import Foundation

/// Action Block
public typealias WPFBannerViewBlock = (_ bannerView: WPFBannerView, _ index: Int) -> Void

/// Action Protocol
@objc public protocol WPFBannerViewDelegate {
    @objc optional func bannerView(_ bannerView: WPFBannerView, didSelectItemAt index: Int)
    @objc optional func bannerView(_ bannerView: WPFBannerView, didScrollItemTo index: Int)
}


//MARK: - LET Project property
struct Constant {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
}

struct Project  {
    static let labelFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    static let labelTextColor: UIColor = UIColor.white
    static let labelBackgroundColor: UIColor = UIColor(white: 0.3, alpha: 0.5)
    static let labelHeight: CGFloat = 21
    static let labelTextAlignment: NSTextAlignment = .left
    
    static let pageControlDotSize: CGSize = CGSize(width: 10, height: 10)
    static let pageControlDotColor: UIColor = UIColor.lightGray
    static let pageControlCurrentDotColor: UIColor = UIColor.white
    static let pageControlBottomOffset: CGFloat = 5
    static let pageControlLeftOffset: CGFloat = 0
}

//MARK: - ENUM
/// WPFBanner Alignment, pageControl has this property setting.
public enum WPFBannerAlignment: Int {
    case left
    case right
    case center
}

/// Banner Style. If you want to see the detail, please clone the iCarousel.
public enum WPFBannerStyle {
     case linear
     case rotary
     case cylinder
     case coverFlow
     case coverFlow2
}

/// PageControl Style.
public enum WPFPageControlStyle {
    /// UIPageControl
    case system
    /// TAPageControl
    case tap
}



