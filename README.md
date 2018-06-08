# WPFBannerView

<p align="left">
<a href="https://travis-ci.org/onevcat/Kingfisher"><img src="https://img.shields.io/travis/onevcat/Kingfisher/master.svg"></a>
<a href="https://github.com/Carthage/Carthage/"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"></a>
<a href="http://onevcat.github.io/Kingfisher/"><img src="https://img.shields.io/cocoapods/v/Kingfisher.svg?style=flat"></a>
<a href="https://raw.githubusercontent.com/onevcat/Kingfisher/master/LICENSE"><img src="https://img.shields.io/cocoapods/l/Kingfisher.svg?style=flat"></a>
</p>

WPFBannerView is simple Swift library for adding banner in your project. This project dependent on some popular libraries. They include [iCarousel(OC library)](https://github.com/nicklockwood/iCarousel) [Kingfisher](https://github.com/onevcat/Kingfisher) etc.

## Requirements
- iOS 9.0+
- Swift 4.0+

## How To Use
The library provides two static convenient method to init your banner. 

```swift
let banner = WPFBannerView.bannerView(frame: CGRect(), imageURLS: [urls], titles: [titles]?, placeholder: nil?, didSelect: { (bannerView, index) in
	// To do something
}, didScroll: {  (bannerView, index) in
	// or nil
})
banner.pageControlDotColor = UIColor.xxx
banner.pageControlDotCurrentColor = UIColor.xxx
self.view.addSubview(banner)
```
and

```swift
let banner = WPFBannerView.bannerView(frame: CGRect(x: 10, y: 50, width: 320, height: 134), imageURLS: remoteImageURLS, titles: [], placeholder: nil, delegate: self)
banner.type = .coverFlow
self.view.addSubview(banner)
```
```swift
func bannerView(_ bannerView: WPFBannerView, didScrollItemTo index: Int) {}
func bannerView(_ bannerView: WPFBannerView, didSelectItemAt index: Int) {}
```

## Installation

There are two way to use WPFBannerView in your project, or directly drag the WPFBannerView file into your project:

- using CocoaPods
- using Carthage

### Installation with CocoaPods
[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Get Started](http://cocoapods.org/#get_started) section for more details.

#### Podfile
```
target 'target’ do
    pod 'WPFBannerView'
end
```


### Installation with Carthage (iOS 8+)

[Carthage](https://github.com/Carthage/Carthage) is a lightweight dependency manager for Swift and Objective-C. It leverages CocoaTouch modules and is less invasive than CocoaPods.

To install with carthage, follow the instruction on [Carthage](https://github.com/Carthage/Carthage)

carthage needs the support of kingfisher

#### Cartfile
```
github "codewpf/WPFBannerView"
github "Kingfisher"
```

### Import headers in your source files

In the source files where you need to use the library, import the header file:

```swift
import WPFBannerView
```

## Contact
Follow and contact me on [Twitter](https://twitter.com/Alex___0394) or [Sina Weibo](http://weibo.com/codewpf ). If you find an issue, just [open a ticket](https://github.com/codewpf/WPFBannerView/issues/new). Pull requests are warmly welcome as well.

## License
WPFBannerView is released under the MIT license. See [LICENSE](https://en.wikipedia.org/wiki/MIT_License) for details.
