//
//  IPTVWebViewController.swift
//  UGDLNA
//
//  Created by mac on 2023/2/1.
//

import UIKit
import WebKit


open class IWebViewController: UIViewController {
    
    private var progressView : UIProgressView? = nil
    private var observation: NSKeyValueObservation? = nil
    
    public var url:URL = URL.init(string: "https://www.baidu.com")!
    lazy var webView: WKWebView = {
        let value = WKWebView()
        return value
    }()
   func leftBarButtonClick(){
        if self.webView.canGoBack{
            self.webView.goBack()
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
 
//        fd_interactivePopDisabled = false
        edgesForExtendedLayout = .init(rawValue: 0)
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        progressView = UIProgressView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 6))
        progressView?.progress = 0.05  // 给一点默认进度欺骗用户
        progressView?.trackTintColor = UIColor.white  // background color
        progressView?.progressTintColor = UIColor.green
        self.view.addSubview(progressView!)
        observation = webView.observe(\.estimatedProgress, options: [.new]) { _, _ in
            let progress = Float(self.webView.estimatedProgress)
            if progress>0.95{
                self.progressView?.isHidden = true
            }else{
                self.progressView?.isHidden = false
                self.progressView!.progress = Float(self.webView.estimatedProgress)
            }
           
        }
        loadData()
       
    }

    func loadData(){
        let req = URLRequest(url: url)
        webView.load(req)
    }
    deinit{
        observation = nil
    }
    
    
}

