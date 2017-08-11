//
//  WPFBannerComponents.swift
//  WPFBannerViewDemo
//
//  Created by alex on 2017/7/28.
//  Copyright © 2017年 http://codewpf.com/. All rights reserved.
//

import Foundation

public typealias WPFBannerViewBlock = (_ bannerView: WPFBannerView, _ index: Int) -> Void

@objc public protocol WPFBannerViewDelegate {
    @objc optional func bannerView(_ bannerView: WPFBannerView, didSelectItemAt index: Int)
    @objc optional func bannerView(_ bannerView: WPFBannerView, didScrollItemTo index: Int)
}


//MARK: - LET Project property
public struct Constant {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
}

public struct Project  {
    
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
public enum WPFBannerAlignment: Int {
    case left
    case right
    case center
}

public enum WPFBannerType {
     case linear
     case rotary
     case cylinder
     case coverFlow
     case coverFlow2
}

public enum WPFPageControlStyle {
    case system
    case tap
}



