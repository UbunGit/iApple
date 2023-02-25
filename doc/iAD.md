# iApple/iAD 使用

## 1:Pod引入
```
pod "iApple/iAD", :git=>"https://github.com/UbunGit/iApple"
```

## 2：使用

### 2.1 初始化

```  swift
// 替换自己的广告id
let adData:ADData = .init(rewarded_time: 240,
                          platforms: [.csj,.google],
                          google: .init(
                            splash: "ca-app-pub-8735546255287972/4391220272",
                            rewarded: "ca-app-pub-8735546255287972/2319041966",
                            expressId: "ca-app-pub-8735546255287972/1744326896"
                          ),
                          csj:.init(appid: "5369408",
                                    splash: "888140834",
                                    rewarded: "951379987",
                                    expressId: "951338398"
                                   )
)
// 搞一个全局的广告控制器
extension ADManage{
    static let defual = ADManage(data: adData)
}
// 启动调用初始化方法
ADManage.defual.setUp()
```

### 2.2 开屏
``` swift
ADManage.defual.showSplash(vc: self) { state in
            
}
```

### 2.2 激励
``` swift
ADManage.defual.showRewarded(vc: self, fineshBlock:{ state in
          
})
```