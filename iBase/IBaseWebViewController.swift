//
//  IBaseWebViewController.swift
//  iApple
//
//  Created by admin on 2024/2/28.
//

import UIKit
import WebKit
import MJRefresh
open class IBaseWebViewController: IBaseViewController, WKNavigationDelegate {

    public var url:URL?
    
    lazy var webView: WKWebView = {
  
        let config = WKWebViewConfiguration()
        let preference = WKPreferences()
        preference.minimumFontSize = 14
        config.preferences = preference
        let value = WKWebView(frame: .zero, configuration: config)
        value.navigationDelegate = self
        value.scrollView.mj_header = MJRefreshGifHeader(refreshingBlock: {
            self.webView.reload()
        })
        value.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        value.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        value.allowsBackForwardNavigationGestures = true
        return value
    }()
    
    lazy var progressView: UIProgressView = {
        let value = UIProgressView()
        value.progressTintColor = .i_accent
        value.transform = CGAffineTransform(scaleX: 1, y: 1.2)
        return value
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    open override func makeUI() {
        super.makeUI()
        view.addSubview(webView)
        webView.addSubview(progressView)
    }
    
    open func webLoad(){
        debugPrint("URL:\(url)")
        guard let url = url else {
            view.tost(msg: "html 错误")
            return
        }
        
        let request = URLRequest.init(url: url)
        webView.load(request)
    }
    
    open override func makeLayout() {
        super.makeLayout()
        webView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webView.scrollView.mj_header?.endRefreshing()
    }
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        view.tost(msg: error.localizedDescription)
        self.webView.scrollView.mj_header?.endRefreshing()
    }
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if progressView.isDescendant(of: webView){
            progressView.isHidden = false
        }
    }

    open override  func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath ==  "estimatedProgress"{
            self.progressView.progress = Float(webView.estimatedProgress)
            if webView.estimatedProgress==1{
                UIView.animate(withDuration: 0.35) {
                    self.progressView.transform = CGAffineTransformMakeScale(1.0, 1);
                } completion: { _ in
                    self.progressView.isHidden = true
                }

            }
        }else if keyPath == "title"{
            title = webView.title
        }
        else{
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    deinit{
        removeObserver(self, forKeyPath:  "estimatedProgress", context: nil)
        removeObserver(self, forKeyPath:  "title", context: nil)
    }
}
