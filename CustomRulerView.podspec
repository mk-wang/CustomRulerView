Pod::Spec.new do |s|
  s.name             = "CustomRulerView"
  s.version          = "1.0.2"
  s.summary          = "CustomRulerView summary"
  s.description      = <<-DESC
    CustomRulerView desc
  DESC
  s.homepage         = "https://github.com/concerned123"
  s.license          = { :type => "MIT", :file => 'COPYING' }
  s.author           = "concerned123"
  s.source           = { :git => "https://github.com/mk-wang/CustomRulerView.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'

  s.source_files = 'CustomRulerView/**/*.{h,m}'
  s.public_header_files = 'CustomRulerView/Public/**/*.{h}'
end

