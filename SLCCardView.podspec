Pod::Spec.new do |s|
s.name         = "SLCCardView"
s.version      = "0.1.1"
s.summary      = "SLCCardView is a view which is card style."
s.homepage     = "https://github.com/WeiKunChao/SLCCardView.git"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "WeiKunChao" => "17736289336@163.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/WeiKunChao/SLCCardView.git", :tag => "0.1.1" }
s.source_files  = "SLCCardView/**/*.{h,m}"
s.public_header_files = "SLCCardView/**/*.h"
s.frameworks = "Foundation", "UIKit"
s.requires_arc = true

end
