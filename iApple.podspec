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
		spec.source_files  =  [
    "iAD/**/*.{h,m,swift}"
    ]
	end
  
  
  spec.subspec 'iView' do |spec|
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
  
  
  

	spec.prefix_header_contents = <<-EOS

	
	EOS
	
	
end
