//
//  ViewController.swift
//  WPFBannerViewDemo
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
        
        let localImageURLS: [String] = [Bundle.main.path(forResource: "banner_1", ofType: "jpg")!,
                              Bundle.main.path(forResource: "banner_2", ofType: "jpg")!,
                              Bundle.main.path(forResource: "banner_3", ofType: "jpg")!]
        
        let remoteImageURLS: [String] =
            ["https://ojurweyf6.qnssl.com/o_1bladv0nkl2qh9g1dv6qm51p599.jpg",
             "https://ojurweyf6.qnssl.com/o_1blf0450e1l2s1n0t180l18jan139.jpg",
             "https://ojurweyf6.qnssl.com/o_1blsfhdba1kc7mg7gdsv81ac59.jpg"]
        
        let banner1 = WPFBannerView.bannerView(frame: CGRect(x: (Constant.screenWidth-320)/2, y: 100, width: 320, height: 134), imageURLS: remoteImageURLS, titles: [], placeholder: nil, didSelect: { (bannerView, index) in
            print("didSelect Block")
            print(bannerView)
            print(index)
        }, didScroll: {  (bannerView, index) in
            print("didScroll Block")
            print(bannerView)
            print(index)
        })
        self.view.addSubview(banner1)
        
        let banner2 = WPFBannerView.bannerView(frame: CGRect(x: (Constant.screenWidth-320)/2, y: 300, width: 320, height: 134), imageURLS: remoteImageURLS, titles: ["测试1","测试2"], placeholder: nil, delegate: self)
        banner2.type = .rotary
        banner2.autoScrollInterval = 3
        banner2.labelTextColor = UIColor.green
        banner2.labelTextFont = UIFont.boldSystemFont(ofSize: 25)
        banner2.labelTextAlignment = .right
        banner2.labelHeight = 40
        banner2.labelBackgroundColor = UIColor.blue
        self.view.addSubview(banner2)

        let banner3 = WPFBannerView.bannerView(frame: CGRect(x: (Constant.screenWidth-320)/2, y: 500, width: 320, height: 180), imageURLS: localImageURLS, titles: [], placeholder: nil, didSelect: { (bannerView, index) in
            print("didSelect Block")
            print(bannerView)
            print(index)
        }) { (bannerView, index) in
            print("didScroll Block")
            print(bannerView)
            print(index)
        }
        banner3.isVertical = true
        banner3.type = .cylinder
        banner3.clipsToBounds = false
        banner3.autoScrollInterval = 4
        self.view.addSubview(banner3)
    
        
    }
    
    func bannerView(_ bannerView: WPFBannerView, didSelectItemAt index: Int) {
        print("didSelect Delegate")
        print(bannerView)
        print(index)
    }

    
    func bannerView(_ bannerView: WPFBannerView, didScrollItemTo index: Int) {
        print("didScroll Delegate")
        print(bannerView)
        print(index)
    }
    
    

    
    

}




