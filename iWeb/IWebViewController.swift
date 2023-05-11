//
//  IPTVWebViewController.swift
//  UGDLNA
//
//  Created by mac on 2023/2/1.
//

import UIKit
import WebKit


open class IWebViewController: UIViewController {
    lazy var leftNavBtn: UIButton = {
        let value = UIButton.init(frame: .init(x: 0, y: 0, width: 32, height: 32))
        value.i_radius = 4
        value.backgroundColor = .systemBackground
        value.tintColor = .secondaryLabel
        value.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        value.addTarget(self, action: #selector(leftNavBtnClicked), for: .touchUpInside)
        return value
    }()
    
    lazy var popBtn: UIButton = {
        let value = UIButton.init(frame: .init(x: 0, y: 0, width: 32, height: 32))
        value.i_radius = 4
        value.tintColor = .secondaryLabel
        value.setImage(UIImage(systemName: "dot.circle"), for: .normal)
        value.addBlock(for: .touchUpInside) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        return value
    }()
  
    private var observation: NSKeyValueObservation? = nil
    public var url:URL = URL.init(string: "https://apps.apple.com/app/id6449018364")!
    lazy var webView: WKWebView = {
        let value = WKWebView()
        value.backgroundColor = .systemBackground
        value.navigationDelegate = self
        return value
    }()
    @objc func leftNavBtnClicked(){
        if self.webView.canGoBack{
            self.webView.goBack()
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
  
    lazy var progressView: UIProgressView = {
        let  progressView = UIProgressView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 6))
        progressView.progress = 0.05  // 给一点默认进度欺骗用户
        progressView.trackTintColor = UIColor.white  // background color
        progressView.progressTintColor = UIColor.green
        return progressView
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeLayout()
      
        observation = webView.observe(\.estimatedProgress, options: [.new]) { _, _ in
            let progress = Float(self.webView.estimatedProgress)
            if progress>0.95{
                self.progressView.isHidden = true
            }else{
                self.progressView.isHidden = false
                self.progressView.progress = Float(self.webView.estimatedProgress)
            }
        }
        loadData()
        
       
    }
    func makeUI(){
        navigationItem.leftBarButtonItem = .init(customView: leftNavBtn)
        navigationItem.rightBarButtonItems = [.init(customView: popBtn)]
        
        view.addSubview(webView)
        self.view.addSubview(progressView)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.shadowColor = .clear
        appearance.backgroundEffect = UIBlurEffect(style: .prominent)
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
      
//        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    func makeLayout(){
        progressView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(6)
        }
         webView.snp.makeConstraints { make in
             make.edges.equalToSuperview()
         }
    }

    func loadData(){
        let req = URLRequest(url: url)
        webView.load(req)
    }
    deinit{
        observation = nil
    }
    
    
}

extension IWebViewController:WKNavigationDelegate{
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.title") { (result, error) in
            if error == nil {
                if let title = result as? String {
                    self.title = title
                }
            }
        }
    }
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        if let title = webView.title {
            self.title = title
        }
    }
}

