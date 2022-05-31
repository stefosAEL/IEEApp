//
//  LoggInWebViewVC.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 14/04/2022.
//

import Foundation
import KeychainSwift
import WebKit


class LogginWebViewVC:UIViewController, WKUIDelegate, WKNavigationDelegate, UINavigationBarDelegate {
    var webView: WKWebView!
    let button = UIButton(frame: CGRect(x: 70, y: 04, width: 44, height: 44))
    let keychain = KeychainSwift()

    var authModel:AuthModel?
    let navBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.backgroundColor = UIColor.white
        return bar
    }()
    public var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webConfiguration = WKWebViewConfiguration()
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(ratingButtonTapped), for: .touchUpInside)
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        self.webView.addSubview(button)
        setupView()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        let topUrl = url!
        let request = NSURLRequest(url: topUrl as URL)
        webView.load(request as URLRequest)

    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
           
            return
        }
        
        print(url.absoluteString)
        if url.absoluteString.contains("code") {
            let code = self.getParameterFrom(url: url.absoluteString, param: "code")
        
            if let code = code {
                print("Code: \(code)")
                DataContext.instance.getToken(code: code, completion: { [weak self] authModel in
                    guard let authModel = authModel else { self?.dismiss(animated: true); return }
                    DataContext.instance.code = code
                    print("Refresh: \(authModel.refresh_token)")
                    DataContext.instance.refreshToken = authModel.refresh_token
                    DataContext.instance.accessToken = authModel.access_token
                    if DataContext.instance.accessToken != "" {
                        self?.keychain.set("\(DataContext.instance.accessToken)", forKey: Configuration.REMEMBER_TOKEN)
                    }
                    if authModel.refresh_token != ""{
                        self?.keychain.set("\(authModel.refresh_token)", forKey: Configuration.REMEMBER_REFRESH_TOKEN)

                    }
                    self?.keychain.set("true", forKey: DataReloadEnum.FORCE_RELOAD_PRIVATE_ANNOUNCEMENTS.rawValue)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let viewcontroller = storyBoard.instantiateViewController(withIdentifier: "PrivateAnnouncementsVC")
                    viewcontroller.modalPresentationStyle = .fullScreen
                    self?.present(viewcontroller, animated: true, completion: nil)
                    
                })
            }
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

    func getParameterFrom(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }

    
    @objc func ratingButtonTapped(){
        self.dismiss(animated: true, completion: nil)
    }



}
    
    

