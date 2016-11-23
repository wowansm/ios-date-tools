Pod::Spec.new do |s|
  s.name         = "SwiftDateTools"
  s.version      = "2.0"
  s.summary      = "Date and time manipulation library written in Swift"
  s.homepage     = "https://github.com/codewise/ios-date-tools"
  s.license      = { :type => "Apache 2.0", :file => "LICENSE" }
  s.author       = { "Paweł Sękara" => "pawel.sekara@gmail.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/codewise/ios-date-tools.git", :tag => "2.0" }

  s.source_files  = "DateTools"
  s.requires_arc = true
end
