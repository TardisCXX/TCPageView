Pod::Spec.new do |s|
  s.name         = "TCPageView"
  s.version      = "0.0.2"
  s.summary      = "一个功能不错的选项视图"
  s.homepage     = "https://github.com/TardisCXX/TCPageView"
  s.license      = "MIT"
  s.author             = { "TardisCXX" => "email@address.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/TardisCXX/TCPageView.git", :tag => s.version }
s.source_files  = "TCPageView", "TCPageViewProject/TCPageView/*.{swift}"
  s.requires_arc = true

end
