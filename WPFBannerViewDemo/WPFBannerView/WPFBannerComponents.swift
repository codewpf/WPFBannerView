//
//  WPFBannerComponents.swift
//  WPFBannerViewDemo
//
//  Created by alex on 2017/7/28.
//  Copyright © 2017年 http://codewpf.com/. All rights reserved.
//

import Foundation

typealias WPFBannerViewBlock = (_ bannerView: WPFBannerView, _ index: Int) -> Void

struct Constant {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
}

struct Project  {
    static let titleLabelHeight: CGFloat = 21
}


@objc protocol WPFBannerViewDelegate {
    @objc optional func bannerView(_ bannerView: WPFBannerView, didSelectItemAt index: Int)
    @objc optional func bannerView(_ bannerView: WPFBannerView, didScrollItemTo index: Int)
}

enum WPFBannerAlignment: Int {
    case left
    case right
    case center
}

enum WPFBannerType {
     case linear
     case rotary
     case cylinder
     case coverFlow
     case coverFlow2
}
