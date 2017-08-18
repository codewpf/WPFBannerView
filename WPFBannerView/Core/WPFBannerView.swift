//
//  WPFBannerView.swift
//  WPFBannerView
//
//  Created by alex on 2017/7/26.
//  Copyright © 2017年 http://codewpf.com/. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - Property & Init
/// WPFBannerView Class
public class WPFBannerView: UIView {
    
    ////////// base //////////
    /// bannerView
    fileprivate let banner: iCarousel
    /// PageControl
    fileprivate var pageControl: UIControl? = nil
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
    fileprivate var pPlaceholder: UIImage? = nil
    /// 图片地址
    fileprivate var pImageURLs: [String] = []
    /// 标题地址
    fileprivate var pTitles: [String] = []
    /// 是否只显示文字，默认false
    fileprivate var pISOnlyText: Bool = false
    
    
    ////////// Setting //////////
    /// 内容模式，默认scaleToFill
    fileprivate var pContentMode: UIViewContentMode = .scaleToFill
    /// 是否无限循环，默认ture
    fileprivate var pISLoop: Bool = true
    
    
    ////////// Timer //////////
    /// 自动滚动时间，默认2秒
    fileprivate var pAutoScrollInterval: Int = 2
    /// 是否自动滚动，默认true
    fileprivate var pISAutoScroll: Bool = true
    

    ////////// PageControl //////////
    /// 是否显示分页控件，默认true
    fileprivate var pPageControlISShow: Bool = true
    /// 是否单页隐藏PageControl，默认false
    fileprivate var pPageControlISHideWhenSingle: Bool = false
    /// pageControl 样式
    fileprivate var pPageControlStyle: WPFPageControlStyle = .system
    /// pageControl 对齐方式
    fileprivate var pPageControlAlignment: WPFBannerAlignment = .center
    /// pageControl tap style dot size, this will automatic set style to tap
    fileprivate var pPageControlDotSize: CGSize = Project.pageControlDotSize
    /// pageControl tap style dot image, this will automatic set style to tap
    fileprivate var pPageControlDotImage: UIImage? = nil
    /// pageControl tap style current dot image, this will automatic set style to tap
    fileprivate var pPageControlCurrentDotImage: UIImage? = nil
    /// pageControl system style dot color, this will automatic set style to system
    fileprivate var pPageControlDotColor: UIColor = Project.pageControlDotColor
    /// pageControl system style current dot color, this will automatic set style to system
    fileprivate var pPageControlCurrentDotColor: UIColor = Project.pageControlCurrentDotColor
    /// pageControl 距离底部的距离
    fileprivate var pPageControlBottomOffset: CGFloat = Project.pageControlBottomOffset
    /// pageControl 距离左边的距离
    fileprivate var pPageControlLeftOffset: CGFloat = Project.pageControlLeftOffset
    
    
    ////////// Label //////////
    /// label 字体
    fileprivate var pLabelFont: UIFont = Project.labelFont
    /// label 字体颜色
    fileprivate var pLabelTextColor: UIColor = Project.labelTextColor
    /// label 背景颜色
    fileprivate var pLabelBackgroundColor: UIColor = Project.labelBackgroundColor
    /// label 高度
    fileprivate var pLabelHeight: CGFloat = Project.labelHeight
    /// label 对齐方式
    fileprivate var pLabelTextAlignment: NSTextAlignment = Project.labelTextAlignment
    
    
    
    fileprivate override init(frame: CGRect) {
        banner = iCarousel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        super.init(frame: frame)
        
        self.pInit()
    }
    required public init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    deinit {
        if self.timer != nil {
            self.timer!.cancel()
            self.timer = nil
        }
    }
}


// MARK: - Calaulate Properties
/// Public Property
public extension WPFBannerView {
    /// 是否只显示文字，默认false
    public var isOnlyText: Bool {
        get {
            return self.pISOnlyText
        }
        set {
            pISOnlyText = newValue
            self.banner.reloadData()
            self.initPageControl()
            self.resetLabel()
        }
    }
    
    /// 内容模式，默认scaleToFill
    public var contentModel: UIViewContentMode {
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

    /// 自动滚动时间
    public var autoScrollInterval: Int {
        get {
            return self.pAutoScrollInterval
        }
        set {
            self.pAutoScrollInterval = newValue
            self.initTimer()
        }
    }
    
    /// banner类型，默认.linear
    public var type: WPFBannerStyle {
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
    public var isVertical: Bool {
        get {
            return self.banner.isVertical
        }
        set {
            self.banner.isVertical = newValue
            self.banner.reloadData()
        }
    }
    /// 是否裁剪视图边界 默认true
    override public var clipsToBounds: Bool {
        get {
            return self.banner.clipsToBounds
        }
        set {
            self.banner.clipsToBounds = newValue
            self.banner.reloadData()
        }
    }
    /// 是否无限循环，默认ture
    public var isLoop: Bool {
        get {
            return self.pISLoop
        }
        set {
            self.pISLoop = newValue
            self.banner.reloadData()
        }
    }
    
    ////////// PageControl //////////
    /// 是否显示分页控件，默认true
    public var pageControlISShow: Bool {
        get {
                return self.pPageControlISShow
        }
        set {
            self.pPageControlISShow = newValue
            self.initPageControl()
        }
    }
    /// 是否单页隐藏PageControl，默认false
    public var pageControlISHideWhenSingle: Bool {
        get {
            return self.pPageControlISHideWhenSingle
        }
        set {
            self.pPageControlISHideWhenSingle = true
            self.initPageControl()
        }
    }
    /// pageControl 样式
    public var pageControlStyle: WPFPageControlStyle {
        get {
            return self.pPageControlStyle
        }
        set {
            self.pPageControlStyle = newValue
            self.initPageControl()
        }
    }
    /// pageControl 对齐方式
    public var pageControlAlignment: WPFBannerAlignment {
        get {
            return self.pPageControlAlignment
        }
        set {
            self.pPageControlAlignment = newValue
            self.resetPageControl()
        }
    }
    /// pageControl tap style dot size, this will automatic set style to tap
    public var pageControlDotSize: CGSize {
        get {
            return self.pPageControlDotSize
        }
        set {
            self.pPageControlDotSize = newValue
            self.pPageControlStyle = .tap
            self.initPageControl()
        }
    }
    /// pageControl tap style dot image, this will automatic set style to tap
    public var pageControlDotImage: UIImage? {
        get {
            return self.pPageControlDotImage
        }
        set {
            self.pPageControlDotImage = newValue
            self.pPageControlStyle = .tap
            self.initPageControl()
        }
    }
    /// pageControl tap style current dot image, this will automatic set style to tap
    public var pageControlCurrentImage: UIImage? {
        get {
            return self.pPageControlDotImage
        }
        set {
            self.pPageControlCurrentDotImage = newValue
            self.pPageControlStyle = .tap
            self.initPageControl()
        }
    }
    /// pageControl system style dot color, this will automatic set style to system
    public var pageControlDotColor: UIColor {
        get {
            return self.pPageControlDotColor
        }
        set {
            self.pPageControlDotColor = newValue
            self.pPageControlStyle = .system
            self.initPageControl()
        }
    }
    /// pageControl system style current dot color, this will automatic set style to system
    public var pageControlDotCurrentColor: UIColor {
        get {
            return self.pPageControlCurrentDotColor
        }
        set {
            self.pPageControlCurrentDotColor = newValue
            self.pPageControlStyle = .system
            self.initPageControl()
        }
    }
    /// pageControl 距离底部的距离
    public var pageControlBottomOffset: CGFloat {
        get {
            return self.pPageControlBottomOffset
        }
        set {
            self.pPageControlBottomOffset = newValue
            self.resetPageControl()
        }
    }
    /// pageControl 距离左边的距离
    public var pageControlLeftOffset: CGFloat {
        get {
            return self.pPageControlLeftOffset
        }
        set {
            self.pPageControlLeftOffset = newValue
            self.resetPageControl()
        }
    }


    
    ////////// Label //////////
    /// label 字体
    public var labelTextFont: UIFont {
        get {
            return self.pLabelFont
        }
        set {
            self.pLabelFont = newValue
            self.resetLabel()
        }
    }
    /// label 字体颜色
    public var labelTextColor: UIColor {
        get {
            return self.pLabelTextColor
        }
        set {
            self.pLabelTextColor = newValue
            self.resetLabel()
        }
    }
    /// label 背景颜色
    public var labelBackgroundColor: UIColor {
        get {
            return self.pLabelBackgroundColor
        }
        set {
            self.pLabelBackgroundColor = newValue
            self.resetLabel()
        }
    }
    /// label 高度
    public var labelHeight: CGFloat {
        get {
            return self.pLabelHeight
        }
        set {
            self.pLabelHeight = newValue
            self.resetLabel()
        }
    }
    /// label 对齐方式
    public var labelTextAlignment: NSTextAlignment {
        get {
            return self.pLabelTextAlignment
        }
        set {
            self.pLabelTextAlignment = newValue
            self.resetLabel()
        }
    }
    

}

// MARK: - Init
/// Convenience static method
public extension WPFBannerView {
    fileprivate func pInit() {
        ///// Banner /////
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
        self.addSubview(self.banner)
        
        self.initTimer()
    }
    
    /// Init with delegate
    public static func bannerView(frame: CGRect, imageURLS: [String], titles: [String]?, placeholder: UIImage?, delegate: WPFBannerViewDelegate?) -> WPFBannerView {
        let bannerView = WPFBannerView(frame: frame)
        bannerView.staticInit(imageURLS: imageURLS, titles: titles, placeholder: placeholder)
        bannerView.delegate = delegate
        return bannerView
    }
    
    /// Init with Block
    public static func bannerView(frame: CGRect, imageURLS: [String], titles: [String]?, placeholder: UIImage?, didSelect select: WPFBannerViewBlock?, didScroll scroll: WPFBannerViewBlock?) -> WPFBannerView {
        let bannerView = WPFBannerView(frame: frame)
        bannerView.staticInit(imageURLS: imageURLS, titles: titles, placeholder: placeholder)
        bannerView.didSelectItem = select
        bannerView.didScrollItem = scroll
        return bannerView
    }
    
    fileprivate func staticInit(imageURLS: [String], titles: [String]?, placeholder: UIImage?) {
        self.pImageURLs = imageURLS
        self.pPlaceholder = placeholder
        self.initImageViews()
        if titles != nil {
            self.pTitles = titles!
            self.initTitleLabes()
        }
        self.banner.reloadData()
        self.initPageControl()
    }

}

// MARK: - Extra Methods
public extension WPFBannerView {
    fileprivate func initImageViews() {
        for urlStr in self.pImageURLs {
            var url: URL? = nil
            if urlStr.hasPrefix("http") {
                url = URL(string: urlStr)
            } else {
                url = URL(fileURLWithPath: urlStr)
            }
            let imageView: UIImageView = UIImageView()
            imageView.frame = CGRect(x: 0, y: 0, width: self.banner.frame.width, height: self.banner.frame.height)
            imageView.kf.setImage(with: url, placeholder: self.pPlaceholder, options: nil)
            self.imageViews.append(imageView)
        }
    }
    
    fileprivate func initTitleLabes() {
        for title in self.pTitles {
            let label: UILabel = UILabel()
            label.frame = CGRect(x: 0, y: self.banner.frame.height-self.pLabelHeight, width: self.banner.frame.width, height: self.pLabelHeight)
            label.text = "  \(title)"
            label.font = self.pLabelFont
            label.backgroundColor = self.pLabelBackgroundColor
            label.textColor = self.pLabelTextColor
            label.textAlignment = self.pLabelTextAlignment
            self.titleLabels.append(label)
        }
    }
    fileprivate func resetLabel() {
        for label in self.titleLabels {
            if self.pISOnlyText == true {
                label.frame = self.bounds
            } else {
                var frame = label.frame
                frame.origin.y = self.banner.frame.height - self.pLabelHeight
                frame.size.height = self.pLabelHeight
                label.frame = frame
            }
            
            label.font = self.pLabelFont
            label.backgroundColor = self.pLabelBackgroundColor
            label.textColor = self.pLabelTextColor
            label.textAlignment = self.pLabelTextAlignment
        }
    }

    
    fileprivate func initPageControl() {
        if self.pageControl != nil {
            self.pageControl!.removeFromSuperview()
            self.pageControl = nil
        }
        if self.pPageControlISShow == false {
            return
        }
        if self.pImageURLs.count == 0 || self.pISOnlyText == true {
            return
        }
        if self.pImageURLs.count == 1 && self.pPageControlISHideWhenSingle == true {
            return
        }
        
        /// 当前banner索引
        let index = self.banner.currentItemIndex
        var count = 0
        if self.pISOnlyText == false {
            count = self.pImageURLs.count
        } else {
            count = self.titleLabels.count
        }
        switch self.pPageControlStyle {
        case .system:
            let pageControl: UIPageControl = UIPageControl()
            pageControl.numberOfPages = count
            pageControl.currentPageIndicatorTintColor = self.pPageControlCurrentDotColor
            pageControl.pageIndicatorTintColor = self.pPageControlDotColor
            pageControl.isUserInteractionEnabled = false
            pageControl.currentPage = index
            let size: CGSize = pageControl.size(forNumberOfPages: count)
            self.pageControl = pageControl
            self.setPageControlFrame(CGSize(width: size.width, height: 21))
            self.addSubview(self.pageControl!)
        case .tap:
            let pageControl = TAPageControl()
            pageControl.numberOfPages = count
            pageControl.dotSize = self.pPageControlDotSize
            if let image = self.pPageControlDotImage {
                pageControl.dotImage = image
            }
            if let currentDotImage = self.pPageControlCurrentDotImage {
                pageControl.currentDotImage = currentDotImage
            }
            pageControl.isUserInteractionEnabled = false
            pageControl.currentPage = index
            let size: CGSize = pageControl.sizeForNumber(ofPages: count)
            self.pageControl = pageControl
            self.setPageControlFrame(size)
            self.addSubview(self.pageControl!)
            pageControl.sizeToFit()
        }
    }
    
    fileprivate func setPageControlFrame(_ size: CGSize) {
        var x = self.pPageControlLeftOffset
        let y = self.frame.size.height - size.height - pPageControlBottomOffset
        switch self.pPageControlAlignment {
        case .left:
            x = 10
        case .center:
            x = (self.frame.size.width - size.width) / 2
        case .right:
            x = self.frame.size.width - size.width - 10
        }
        let frame = CGRect(x: x, y: y, width: size.width, height: size.height)
        self.pageControl!.frame = frame
    }
    
    /// 重设 PageControle 个别属性
    fileprivate func resetPageControl() {
        guard self.pageControl != nil else {
            return
        }
        
        self.setPageControlFrame(self.pageControl!.frame.size)
        if self.pPageControlBottomOffset != 0 {
            var frame = self.pageControl!.frame
            frame.origin.y = frame.origin.y - self.pPageControlBottomOffset
            self.pageControl!.frame = frame
        }
        if self.pPageControlLeftOffset != 0 {
            var frame = self.pageControl!.frame
            frame.origin.x = frame.origin.x + self.pPageControlLeftOffset
            self.pageControl!.frame = frame
        }
    }
    
    /// 初始化计时器
    fileprivate func initTimer() {
        if self.timer != nil {
            self.timer!.cancel()
            self.timer = nil
        }
        self.timer = WPFTimer(interval: .seconds(self.pAutoScrollInterval), repeats: true, queue: .main, handler: { (timer) in
            self.timerAction()
        })
        self.timer!.start()
    }
    
    /// 计时器方法
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
/// iCarouse Delegate
extension WPFBannerView: iCarouselDataSource, iCarouselDelegate {
    public func numberOfItems(in carousel: iCarousel) -> Int {
        if self.pISOnlyText {
            return self.pTitles.count
        } else {
            return self.imageViews.count
        }
    }
    public func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
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
    public func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
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
    
    public func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        if self.delegate != nil {
            self.delegate!.bannerView!(self, didSelectItemAt: index)
        }
        if self.didSelectItem != nil {
            self.didSelectItem!(self, index)
        }
    }
    
    public func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        if self.pageControl != nil {
            switch self.pPageControlStyle {
            case .system:
                let pageControl: UIPageControl = self.pageControl as! UIPageControl
                pageControl.currentPage = carousel.currentItemIndex
            case .tap:
                let pageControl: TAPageControl = self.pageControl as! TAPageControl
                pageControl.currentPage = carousel.currentItemIndex
            }
        }
        if self.delegate != nil {
            self.delegate!.bannerView!(self, didScrollItemTo: carousel.currentItemIndex)
        }
        if self.didScrollItem != nil {
            self.didScrollItem!(self, carousel.currentItemIndex)
        }
    }
    
}

