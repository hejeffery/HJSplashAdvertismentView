#
#  Be sure to run `pod spec lint HJSplashAdvertismentView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "HJSplashAdvertismentView"
  s.version      = "1.0.0"
  s.summary      = "A simple advertisment view for splash"
  s.description  = <<-DESC
                   DESC
  s.homepage     = "https://github.com/hejeffery/HJSplashAdvertismentView.git"
  s.license      = "MIT"
  s.author             = { "hejeffery" => "553504116@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/hejeffery/HJSplashAdvertismentView.git", :tag => "v1.0.0" }
  s.source_files  = "HJSplashAdvertismentView/*.{h,m}"
  s.requires_arc = true
  s.dependency 'SDWebImage'
  s.dependency 'Masonry'
end
