Pod::Spec.new do |s|
    s.name         = "SGSegmentedProgressBarLibrary"
    s.version      = "0.0.5"
    s.summary      = "A segmented progress bar designed by UIView"
    s.description  = <<-DESC
    Library to add a segmented progress bar like as Instagram, whatsapp.
    DESC
    s.homepage     = "https://github.com/sanjeevworkstation/SGSegmentedProgressBarLibrary"
    s.license = { :type => 'Copyright', :text => <<-LICENSE
                   Copyright 2020 Sanjeev Gautam
                  LICENSE
                }
    s.author             = { "Sanjeev Gautam" => "sanjeevworkstation@gmail.com" }
    s.source       = { :git => "https://github.com/sanjeevworkstation/SGSegmentedProgressBarHost.git", :tag => "#{s.version}" }
    s.source_files = "SGSegmentedProgressBarLibrary/SGSegmentedProgressBarLibrary/**/*.{swift}"
    s.platform = :ios
    s.swift_version = "4.2"
    s.ios.deployment_target  = '9.0'
end