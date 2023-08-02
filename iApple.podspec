Pod::Spec.new do |spec|
  
  spec.name         = "iApple"
  spec.version      = "1.0.0"
  spec.summary      = "用户信息"
  
  spec.description  = "ios用户信息"
  
  spec.homepage     = "http://github/ubungit.git"
  
  
  spec.license      = "MIT"
  
  spec.author             = { "静静地白色外套" => "296019487@qq.com" }
  
  spec.source       = { :git => "http://github/ubungit.git", :tag => "#{spec.version}" }

  spec.default_subspec = 'iKit'
  
  spec.subspec 'iKit' do |spec|
    spec.dependency "YYCategories"
    spec.source_files  =  [
    "iKit/**/*.{h,m,swift}"
    ]
  end
  spec.subspec 'iBox' do |spec|
    spec.dependency "iApple/iKit"
    spec.source_files  =  [
    "iBox/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iAPI' do |spec|
    spec.source_files  =  [
    "iAPI/**/*.{h,m,swift}"
    ]
  end

  spec.subspec 'iLog' do |spec|
    spec.dependency "iApple/iBox"
    spec.source_files  =  [
    "iLog/**/*.{h,m,swift}"
    ]
  end
  spec.subspec 'iAD' do |spec|
    
    spec.dependency "Ads-CN"
    spec.dependency "Google-Mobile-Ads-SDK"
    spec.dependency "iApple/iBox"
    spec.dependency "iApple/iLog"
    spec.dependency "iApple/iView"
    spec.dependency "iApple/iHub"
    spec.source_files  =  [
    "iAD/**/*.{h,m,swift}"
    ]
  end
  
  
  spec.subspec 'iView' do |spec|
    
    spec.dependency "SDWebImage"
    spec.dependency "SnapKit"
    spec.dependency "iApple/iBox"
    spec.source_files  =  [
    "iView/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iRouter' do |spec|
    spec.dependency "iApple/iBox"
    spec.source_files  =  [
    "iRouter/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iRealm' do |spec|
    
    spec.dependency "RealmSwift"
    spec.source_files  =  [
    "iRealm/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iStore' do |spec|
    spec.dependency "iApple/iBox"
    spec.dependency "iApple/iHub"
    
    spec.source_files  =  [
    "iStore/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iWeb' do |spec|
    
    spec.dependency "SnapKit"
#    spec.dependency "iApple/iBox"
    spec.source_files  =  [
    "iWeb/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iSystem' do |spec|
    
    spec.dependency "SnapKit"
    spec.dependency "iApple/iBox"
    spec.source_files  =  [
    "iSystem/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iHub' do |spec|
    spec.dependency "SnapKit"
    spec.dependency "MBProgressHUD"
    spec.dependency "YYCategories"
    
    spec.source_files  =  [
    "iHub/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iVideoPlayer' do |spec|
    spec.dependency "SDWebImage"
    spec.dependency "SnapKit"
    spec.dependency "iApple/iBox"
    spec.dependency "FDFullscreenPopGesture"
    spec.dependency "SJVideoPlayer"
  
    spec.dependency  "PodIJKPlayer"
    spec.source_files  =  [
    "iVideoPlayer/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iOpenAI' do |spec|

    
    spec.source_files  =  [
    "iOpenAI/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iRandom' do |spec|

    
    spec.source_files  =  [
    "iRandom/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iMeidaImport' do |spec|

    spec.dependency "iApple/iBox"
    spec.source_files  =  [
    "iMeidaImport/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iFromTableViewCell' do |spec|
    spec.dependency "SnapKit"
    spec.dependency "IQKeyboardManagerSwift"
    spec.dependency "PGDatePicker"
    
    spec.dependency "iApple/iView"
    spec.source_files  =  [
    "iFromTableViewCell/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iProgressView' do |spec|
    spec.source_files  =  [
    "iProgressView/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iM3u8' do |spec|
    
    spec.dependency "Alamofire"
    spec.source_files  =  [
    "iM3u8/**/*.{h,m,swift}"
    ]
  end
  
  
  spec.subspec 'iBander' do |spec|
    spec.dependency "SnapKit"
    spec.source_files  =  [
    "iBander/**/*.{h,m,swift}"
    ]
  end
  spec.subspec 'iSCalendar' do |spec|
    spec.source_files  =  [
    "iSCalendar/**/*.{h,m,swift}"
    ]
  end
  spec.subspec 'iCloudKit' do |spec|
    
    spec.dependency "iApple/iSqlite"
    spec.source_files  =  [
    "iCloudKit/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iSqlite' do |spec|
    
    spec.dependency "FMDB"
    spec.source_files  =  [
    "iSqlite/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iRichView' do |spec|
    
    spec.dependency "FMDB"
    spec.source_files  =  [
    "iRichView/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iLogin' do |spec|
    spec.dependency "IQKeyboardManagerSwift"
    spec.dependency "SnapKit"
    spec.source_files  =  [
    "iLogin/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iSetting' do |spec|

    spec.dependency "SnapKit"
    spec.source_files  =  [
    "iSetting/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iChart' do |spec|
    spec.source_files  =  [
    "iChart/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'DorKit' do |spec|
    spec.dependency 'DoraemonKit/Core'
    spec.source_files  =  [
    "DorKit/**/*.{h,m,swift}"
    ]
  end
 

  spec.prefix_header_contents = <<-EOS
  
  
  EOS
  
  
end
