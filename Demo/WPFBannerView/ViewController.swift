//
//  ViewController.swift
//  WPFBannerView
//
//  Created by alex on 2017/6/24.
//  Copyright © 2017年 http://codewpf.com/. All rights reserved.
//

import UIKit


class ViewController: UIViewController, WPFBannerViewDelegate {

    let imageNames: [String] = ["", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let scroll = UIScrollView(frame: self.view.bounds)
        scroll.contentSize = CGSize(width: scroll.frame.size.width, height: scroll.frame.size.height*1.5)
        self.view.addSubview(scroll)
        
        
        let localImageURLS: [String] = [Bundle.main.path(forResource: "banner_1", ofType: "jpg")!,
                              Bundle.main.path(forResource: "banner_2", ofType: "jpg")!,
                              Bundle.main.path(forResource: "banner_3", ofType: "jpg")!]
        
        let remoteImageURLS: [String] =
            ["https://ojurweyf6.qnssl.com/o_1bladv0nkl2qh9g1dv6qm51p599.jpg",
             "https://ojurweyf6.qnssl.com/o_1blf0450e1l2s1n0t180l18jan139.jpg",
             "https://ojurweyf6.qnssl.com/o_1blsfhdba1kc7mg7gdsv81ac59.jpg"]
        
        let banner1 = WPFBannerView.bannerView(frame: CGRect(x: (Constant.screenWidth-320)/2, y: 50, width: 320, height: 134), imageURLS: remoteImageURLS, titles: [], placeholder: nil, didSelect: { (bannerView, index) in
        }, didScroll: {  (bannerView, index) in
        })
        banner1.pageControlDotColor = UIColor.green
        banner1.pageControlDotCurrentColor = UIColor.black
        scroll.addSubview(banner1)
        
        let banner2 = WPFBannerView.bannerView(frame: CGRect(x: (Constant.screenWidth-320)/2, y: 220, width: 320, height: 134), imageURLS: remoteImageURLS, titles: ["测试1","测试2"], placeholder: nil, delegate: self)
        banner2.type = .rotary
        banner2.autoScrollInterval = 3
        banner2.labelTextColor = UIColor.green
        banner2.labelTextFont = UIFont.boldSystemFont(ofSize: 25)
        banner2.labelTextAlignment = .right
        banner2.labelHeight = 40
        banner2.labelBackgroundColor = UIColor.blue
        scroll.addSubview(banner2)

        let banner3 = WPFBannerView.bannerView(frame: CGRect(x: (Constant.screenWidth-320)/2, y: 390, width: 320, height: 180), imageURLS: localImageURLS, titles: [], placeholder: nil, didSelect: { (bannerView, index) in
        }) { (bannerView, index) in
        }
        banner3.isVertical = true
        banner3.type = .cylinder
        banner3.clipsToBounds = false
        banner3.autoScrollInterval = 4
        banner3.pageControlDotSize = CGSize(width: 10, height: 10)
        scroll.addSubview(banner3)
        
        let banner4 = WPFBannerView.bannerView(frame: CGRect(x: (Constant.screenWidth-320)/2, y: 600, width: 320, height: 180), imageURLS: localImageURLS, titles: [], placeholder: nil, didSelect: { (bannerView, index) in
        }) { (bannerView, index) in
        }
        banner4.type = .coverFlow
        banner4.autoScrollInterval = 3
        banner4.pageControlDotImage = UIImage(named: "dot_image")
        banner4.pageControlCurrentImage = UIImage(named: "current_dot_image")
        scroll.addSubview(banner4)
        
        let banner5 = WPFBannerView.bannerView(frame: CGRect(x: (Constant.screenWidth-320)/2, y: 800, width: 320, height: 50), imageURLS: localImageURLS, titles: ["测试1","测试2","测试3"], placeholder: nil, didSelect: { (bannerView, index) in
        }) { (bannerView, index) in
        }
        banner5.isVertical = true
        banner5.isOnlyText = true
        banner5.labelBackgroundColor = UIColor.blue
        banner5.labelTextColor = UIColor.red
        banner5.labelTextAlignment = .center
        scroll.addSubview(banner5)
    
        
    }
    
    func bannerView(_ bannerView: WPFBannerView, didSelectItemAt index: Int) {
    }

    
    func bannerView(_ bannerView: WPFBannerView, didScrollItemTo index: Int) {
    }
    
    

    
    

}




