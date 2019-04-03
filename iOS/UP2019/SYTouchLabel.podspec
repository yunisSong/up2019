Pod::Spec.new do |s|
  s.name         = "SYTouchLabel"
  s.version      = "0.0.1"
  s.summary      = "轻量级可点击 Label"
  s.description  = "轻量级可点击 Label"
  s.homepage     = "https://github.com/yunisSong/up2019/tree/master/iOS/UP2019/SYTouchLabel"
  s.license= { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Yunis" => "332963965@qq.com" }
  s.source       = { :git => "https://github.com/yunisSong/up2019.git" }
  s.source_files = "iOS/UP2019/SYTouchLabel/*.{h,m}"
  s.ios.deployment_target = '6.0'
  s.requires_arc = true

end
