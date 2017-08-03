//
//  WPFBannerView.swift
//  WPFBannerViewDemo
//
//  Created by alex on 2017/7/26.
//  Copyright © 2017年 http://codewpf.com/. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - Property & Init
class WPFBannerView: UIView {
    
    ////////// base //////////
    /// bannerView
    fileprivate let banner: iCarousel
    /// ImageViews
    fileprivate var imageViews: [UIImageView] = []
    /// TitleLabels
    fileprivate var titleLabels: [UILabel] = []
    /// 计时器
    fileprivate var timer: WPFTimer? = nil
    
    ////////// Callback //////////
    /// 代理
    fileprivate var delegate: WPFBannerViewDelegate? = nil
    ////////// Block //////////
    /// 点击Block
    fileprivate var didSelectItem: WPFBannerViewBlock? = nil
    /// 滚动Block
    fileprivate var didScrollItem: WPFBannerViewBlock? = nil
    
    ////////// DataSources //////////
    /// 占位图
    fileprivate var placeholder: UIImage? = nil
    /// 图片地址
    fileprivate var imageURLs: [String] = []
    /// 标题地址
    fileprivate var titles: [String] = []
    /// 是否只显示文字，默认false
    fileprivate var pISOnlyText: Bool = false
    
    ////////// Calculate //////////
    /// 内容模式，默认scaleToFill
    fileprivate var pContentMode: UIViewContentMode = .scaleToFill
    /// 是否无限循环，默认ture
    fileprivate var pISLoop: Bool = true

    
    
    
    ////////// Setting //////////
    /// 自动滚动时间，默认2秒
    var pAutoScrollInterval: Int = 2
    /// 是否自动滚动，默认true
    var pISAutoScroll: Bool = true
    

    ////////// PageControl //////////
    /// 是否显示分页控件，默认true
    var isShowPageControl: Bool = true
    /// 是否单页隐藏PageControl，默认false
    var isHidePageControlWhenSingle: Bool = false
    /// pageControl 对齐方式
    var pageControlAlignment: WPFBannerAlignment = .center
    
    ////////// Label //////////

    
    
    
    
    fileprivate override init(frame: CGRect) {
        banner = iCarousel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        super.init(frame: frame)
        
        /// static
        self.banner.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.banner.bounceDistance = 0.2
        self.banner.isPagingEnabled = true
        self.banner.dataSource = self
        self.banner.delegate = self
        
        /// calculate
        self.banner.type = .linear
        self.banner.isVertical = false
        self.banner.clipsToBounds = true

        self.initTimer()
        
        self.addSubview(self.banner)
    }
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


// MARK: - Calaulate Properties
extension WPFBannerView {
    /// 是否只显示文字，默认false
    var isOnlyText: Bool {
        get {
            return self.pISOnlyText
        }
        set {
            pISOnlyText = newValue
            self.banner.reloadData()
        }
    }
    
    /// 内容模式，默认scaleToFill
    var contentModel: UIViewContentMode {
        get {
            return self.pContentMode
        }
        set {
            self.pContentMode = newValue
            for iv in self.imageViews {
                iv.contentMode = self.pContentMode
            }
        }
    }

    var autoScrollInterval: Int {
        get {
            return self.pAutoScrollInterval
        }
        set {
            self.pAutoScrollInterval = newValue
            self.initTimer()
        }
    }

    
    
    /// banner类型，默认.linear
    var type: WPFBannerType {
        get {
            switch self.banner.type {
            case .linear: return .linear
            case .rotary: return .rotary
            case .cylinder: return .cylinder
            case .coverFlow: return .coverFlow
            case .coverFlow2: return .coverFlow2
            default: return .linear
            }
        }
        set {
            switch newValue {
            case .linear: self.banner.type = .linear
            case .rotary: self.banner.type = .rotary
            case .cylinder: self.banner.type = .cylinder
            case .coverFlow: self.banner.type = .coverFlow
            case .coverFlow2: self.banner.type = .coverFlow2
            }
            self.banner.reloadData()
        }
    }
    /// 是否垂直滚动，默认false
    var isVertical: Bool {
        get {
            return self.banner.isVertical
        }
        set {
            self.banner.isVertical = newValue
            self.banner.reloadData()
        }
    }
    /// 是否裁剪视图边界 默认true
    override var clipsToBounds: Bool {
        get {
            return self.banner.clipsToBounds
        }
        set {
            self.banner.clipsToBounds = newValue
            self.banner.reloadData()
        }
    }
    /// 是否无限循环，默认ture
    var isLoop: Bool {
        get {
            return self.pISLoop
        }
        set {
            self.pISLoop = newValue
            self.banner.reloadData()
        }
    }

}

// MARK: - Static Init
extension WPFBannerView {
    static func bannerView(frame: CGRect, imageURLS: [String], titles: [String]?, placeholder: UIImage?, delegate: WPFBannerViewDelegate) -> WPFBannerView {
        let bannerView = WPFBannerView(frame: frame)
        bannerView.staticInit(imageURLS: imageURLS, titles: titles, placeholder: placeholder)
        bannerView.delegate = delegate
        return bannerView
    }
    static func bannerView(frame: CGRect, imageURLS: [String], titles: [String]?, placeholder: UIImage?, didSelect select: WPFBannerViewBlock?, didScroll scroll: WPFBannerViewBlock? = nil) -> WPFBannerView {
        let bannerView = WPFBannerView(frame: frame)
        bannerView.staticInit(imageURLS: imageURLS, titles: titles, placeholder: placeholder)
        bannerView.didSelectItem = select
        bannerView.didScrollItem = scroll
        return bannerView
    }
    
    fileprivate func staticInit(imageURLS: [String], titles: [String]?, placeholder: UIImage?) {
        self.imageURLs = imageURLS
        self.placeholder = placeholder
        self.initImageViews()
        if titles != nil {
            self.titles = titles!
            self.pageControlAlignment = .right
            self.initTitleLabes()
        }
        self.banner.reloadData()
    }

}

// MARK: - Private Methods
extension WPFBannerView {
    fileprivate func initImageViews() {
        for urlStr in self.imageURLs {
            var url: URL? = nil
            if urlStr.hasPrefix("http") {
                url = URL(string: urlStr)
            } else {
                url = URL(fileURLWithPath: urlStr)
            }
            let imageView: UIImageView = UIImageView()
            imageView.frame = CGRect(x: 0, y: 0, width: self.banner.frame.width, height: self.banner.frame.height)
            imageView.kf.setImage(with: url, placeholder: self.placeholder, options: nil)
            self.imageViews.append(imageView)
        }
    }
    
    fileprivate func initTitleLabes() {
        for title in self.titles {
            let label: UILabel = UILabel()
            label.frame = CGRect(x: 0, y: self.banner.frame.height-Project.titleLabelHeight, width: self.banner.frame.width, height: Project.titleLabelHeight)
            label.text = "  \(title)"
            label.font = UIFont.systemFont(ofSize: 13)
            label.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
            label.textColor = UIColor.white
            label.textAlignment = .left
            
            self.titleLabels.append(label)
        }
    }
    
    fileprivate func initTimer() {
        self.timer?.cancel()
        self.timer = nil
        self.timer = WPFTimer(interval: .seconds(self.pAutoScrollInterval), repeats: true, queue: .main, handler: { (timer) in
            self.timerAction()
        })
        self.timer?.start()
    }
    
    fileprivate func timerAction() {
        var index: Int = self.banner.currentItemIndex + 1
        if pISOnlyText {
            if index == self.titleLabels.count {
                index = 0
            }
        } else {
            if index == self.imageViews.count {
                index = 0
            }
        }
        self.banner.scrollToItem(at: index, animated: true)
    }
    
    
}


// MARK: - Delegate
extension WPFBannerView: iCarouselDataSource, iCarouselDelegate {
    func numberOfItems(in carousel: iCarousel) -> Int {
        if self.pISOnlyText {
            return self.titles.count
        } else {
            return self.imageViews.count
        }
    }
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        if self.pISOnlyText {
            return self.titleLabels[index]
        } else {
            let iv: UIImageView = self.imageViews[index]
            for sub in iv.subviews {
                sub.removeFromSuperview()
            }
            if self.titleLabels.count > index {
                iv.addSubview(self.titleLabels[index])
            }
            return iv
        }
    }
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch option {
        case .wrap:
            if self.pISLoop {
                return 1
            } else {
                return 0
            }
        default:
            return value
        }
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        if self.delegate != nil {
            self.delegate!.bannerView!(self, didSelectItemAt: index)
        }
        if self.didSelectItem != nil {
            self.didSelectItem!(self, index)
        }
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        if self.delegate != nil {
            self.delegate!.bannerView!(self, didScrollItemTo: carousel.currentItemIndex)
        }
        if self.didScrollItem != nil {
            self.didScrollItem!(self, carousel.currentItemIndex)
        }
    }
    
}

