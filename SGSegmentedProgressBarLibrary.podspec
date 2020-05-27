Pod::Spec.new do |spec|

   spec.name          = "SGSegmentedProgressBarLibrary"

  spec.version        = "0.0.1"

  spec.summary        = "a segmented progress bar"

  spec.description    = "Library to add a segmented progress bar like as Instagram, whatsapp"

  spec.homepage       = "https://github.com/sanjeevworkstation/SGSegmentedProgressBarLibrary"

  spec.license        = { :type => "MIT", :file => "LICENSE" }

  spec.author         = { "Sanjeev Gautam" => "sanjeevworkstation@gmail.com" }

  spec.platform       = :ios, "9.0"
  spec.swift_version  = '4.2'

  spec.source         = { :git => "https://github.com/sanjeevworkstation/SGSegmentedProgressBarLibrary.git", :tag => '0.0.1' }

  #spec.source_files   = "SGSegmentedProgressViewLibrary/SGSegmentedProgressViewLibrary/**/*.{swift}"

  spec.vendored_frameworks = 'SGSegmentedProgressBarLibrary/SGSegmentedProgressBarLibrary/SGSegmentedProgressBar.framework'

end