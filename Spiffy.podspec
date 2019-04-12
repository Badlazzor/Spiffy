Pod::Spec.new do |s|
  s.name          = 'Spiffy'
  s.version       = '0.0.1'
  s.license       = { :type => "MIT", :file => "LICENSE.md" }
  s.homepage      = 'https://github.com/Badlazzor/Spiffy'
  s.authors       = { 'Balázs Hajagos' => 'badlazzor@gmail.com' }
  s.summary       = "Spiffy is a lightweight styling library for iOS applications"
  s.description   = <<-DESC
Spiffy is a lightweight styling library tailored to be as easy to use and as extensible as possible while maintaining a coherent coding experience.
                       DESC
  s.source        = { :git => 'https://github.com/Badlazzor/Spiffy.git', :tag => s.version.to_s }
  s.requires_arc  = true
  s.swift_version = '4.2'

  s.source_files   = 'Spiffy/**/*.{swift,h,m}'
  s.ios.framework  = 'UIKit'
  s.ios.deployment_target  = '9.0'
end
