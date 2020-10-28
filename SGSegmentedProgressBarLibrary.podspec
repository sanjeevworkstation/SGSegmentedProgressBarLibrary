Pod::Spec.new do |spec|

   spec.name          = "SGSegmentedProgressBarLibrary"

  spec.version        = "0.0.5"

  spec.summary        = "a segmented progress bar"

  spec.description    = "Library to add a segmented progress bar like as Instagram, whatsapp"

  spec.homepage       = "https://github.com/sanjeevworkstation/SGSegmentedProgressBarLibrary"

  spec.license        = { :type => "MIT", :file => "LICENSE" }

  spec.author         = { "Sanjeev Gautam" => "sanjeevworkstation@gmail.com" }

  spec.platform       = :ios, "9.0"

  spec.swift_version  = '4.2'

  spec.source         = { :git => "https://github.com/sanjeevworkstation/SGSegmentedProgressBarHost.git", :tag => '0.0.5' }

  spec.vendored_frameworks = 'SGSegmentedProgressBarFramework.xcframework'

end