Pod::Spec.new do |s|
  s.name             = 'BottomCard'
  s.version          = '0.5.0'
  s.summary          = 'There are alternatives like Pulley or FloatingPanel'
 
  s.description      = <<-DESC
BottomCardView is a UI library written in Swift. It makes easier to develop overlay based interfaces
                       DESC
 
  s.homepage         = 'https://github.com/EvgeniyGulkov/BottomCard'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Evgeny Gulkov' => 'ewgeniy2004@list.ru' }
  s.source           = { :git => 'https://github.com/EvgeniyGulkov/BottomCard.git', :tag => s.version.to_s }
  s.dependency 'pop'
 
  s.ios.deployment_target = '11.0'
  s.swift_versions = '5.0'
  s.source_files = 'BottomCard/Sources/*.swift'
 
end
