Pod::Spec.new do |s|

    s.name         = "WPFBannerView"
    s.version      = "0.5.1"
    s.summary      = "A convenient way to init BannerView"
    s.license      = 'MIT'

    s.homepage     = "https://github.com/codewpf/WPFBannerView"

    s.author             = { "alex" => "ioswpf@gmail.com" }
    # s.social_media_url   = "https://twitter.com/Alex___0394"

    s.platform     = :ios, "10.0"

    s.source       = { :git => "https://github.com/codewpf/WPFBannerView.git", :tag => "#{s.version}" }

    s.source_files  = "WPFBannerView", "WPFBannerView/**/*.{h,m}", "WPFBannerView/**/*.{swift}", "WPFBannerView/*.{h}"

    s.requires_arc = true

    s.dependency "Kingfisher", "~> 5.0"

    s.swift_version = '5.0'

end
