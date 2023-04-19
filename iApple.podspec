Pod::Spec.new do |spec|
  
  spec.name         = "iApple"
  spec.version      = "1.0.0"
  spec.summary      = "用户信息"
  
  spec.description  = "ios用户信息"
  
  spec.homepage     = "http://github/ubungit.git"
  
  
  spec.license      = "MIT"
  
  spec.author             = { "静静地白色外套" => "296019487@qq.com" }
  
  spec.ios.deployment_target = '11'
  
  spec.source       = { :git => "http://github/ubungit.git", :tag => "#{spec.version}" }
  
  
  spec.dependency "YYCategories"
  
  spec.default_subspec = 'iBox'
  
  spec.subspec 'iBox' do |spec|
    spec.source_files  =  [
    "iBox/**/*.{h,m,swift}"
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
  
  spec.subspec 'iInputTableViewCell' do |spec|
    spec.dependency "SnapKit"
    spec.dependency "IQKeyboardManagerSwift"
    spec.dependency "iApple/iView"
    spec.source_files  =  [
    "iInputTableViewCell/**/*.{h,m,swift}"
    ]
  end
  
  spec.subspec 'iProgressView' do |spec|
    spec.source_files  =  [
    "iProgressView/**/*.{h,m,swift}"
    ]
  end
  
  
  
  
  

  spec.prefix_header_contents = <<-EOS
  
  
  EOS
  
  
end
