
Pod::Spec.new do |s|
  s.name         = "BlockObserver"
  s.version      = "0.2.2"
  s.summary      = "Blockchain observer"

  s.description  = <<-DESC
    Observe new transactions on different blockchains
                   DESC

  s.homepage     = "https://github.com/impul/BlockObserver.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "impul" => "pavlo.bojkoo@gmail.com" }

  s.swift_version= '5'
  s.static_framework  = true

  s.ios.deployment_target = "11.0"
  s.osx.deployment_target = "10.12"

  s.source       = { :git => "https://github.com/impul/BlockObserver.git", :tag => "#{s.version}" }

  s.module_name   = "BlockObserver"
  s.source_files  = "Sources/**/*.swift"

end
