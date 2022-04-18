//
//  LoggInWebViewVC.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 14/04/2022.
//

import Foundation
import WebKit

class LogginWebViewVC:UIViewController, WKUIDelegate, WKNavigationDelegate, UINavigationBarDelegate {
    var webView: WKWebView!    
    let navBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.backgroundColor = UIColor.white
        return bar
    }()
    public var url: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        setupView()
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        let topUrl = NSURL(string: url)!
        let request = NSURLRequest(url: topUrl as URL)
        webView.load(request as URLRequest)

    }
 
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        if url.absoluteString.contains("https://login.iee.ihu.gr/") {
            webView.allowsLinkPreview = false
            decisionHandler(.allow)
        } else {
            decisionHandler(.allow)
        }
    }
    func setupView() {
        view.addSubview(navBar)
        view.addSubview(webView)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        navBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        navBar.heightAnchor.constraint(equalToConstant: 100).isActive = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}
    
    

