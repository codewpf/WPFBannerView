Pod::Spec.new do |s|

  s.name         = "WPFBannerView"
  s.version      = "0.2.5"
  s.summary      = "A convenient way to init BannerView"

 s.description   = <<-DESC
                   WPFBannerView help you to add a bannerView on you view in one minute.
                   DESC

  s.homepage     = "https://github.com/codewpf/WPFBannerView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "alex" => "ioswpf@gmail.com" }
  #s.social_media_url   = "https://twitter.com/Alex___0394"

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/codewpf/WPFBannerView.git", :tag => "#{s.version}" }


  s.source_files = ["WPFBannerViewDemo/WPFBannerView/WPFBannerView.swift", "WPFBannerViewDemo/WPFBannerView/*.swift", "WPFBannerViewDemo/WPFBannerView/**/*.{h,m}"]


  s.requires_arc = true

  s.dependency "Kingfisher", "~> 3.0"

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }

end
