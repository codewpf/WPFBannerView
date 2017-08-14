Pod::Spec.new do |s|


    s.name         = "WPFBannerView"
    s.version      = "0.2.7"
    s.summary      = "A convenient way to init BannerView"
    s.license      = 'MIT'

    s.homepage     = "https://github.com/codewpf/WPFBannerView"

    s.author             = { "alex" => "ioswpf@gmail.com" }
    # s.social_media_url   = "https://twitter.com/Alex___0394"

    s.platform     = :ios, "8.0"

    s.source       = { :git => "https://github.com/codewpf/WPFBannerView.git", :tag => "#{s.version}" }

    s.source_files  = "WPFBannerView", "WPFBannerView/**/*.{h,m}", "WPFBannerView/**/*.{swift}", "WPFBannerView/*.{h}"

    s.requires_arc = true

    s.dependency "Kingfisher", "~> 3.0"








end
