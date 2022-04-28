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
    public var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
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
//                DataContext.instance.getAccessToken(client_id: "62408ef084b2a60fc0ba856c", client_secret: "4mtxqivi27efteqcmkgzc7v7ex97o8ak4qjggack3jo07lfzaq", code: code, grant_type: "authorization_code", completion: {  response in
//                    if let response = response {
//                        print(response.access_token)
//                        DataContext.instance.accessToken = response.access_token
//                        DataContext.instance.refreshToken = response.refresh_token
//                    }
//                })
//                dismiss(animated: true)
                getToken(code: code)
                print(code)
                
                
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

    func getToken(code: String) {
        let semaphore = DispatchSemaphore (value: 0)

        let parameters = "grant_type=authorization_code&client_id=62408ef084b2a60fc0ba856c&client_secret=4mtxqivi27efteqcmkgzc7v7ex97o8ak4qjggack3jo07lfzaq&code=\(code)"
        let postData =  parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://login.iee.ihu.gr/token")!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("connect.sid=s%3Axd_v-ikpMWEEHhw-QMJDT8B0hbFgl9Yl.9zywdEQreC5wdmSPD%2BA4Gq9Jc3xkris4a%2FrAnsUdnQE", forHTTPHeaderField: "Cookie")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
            print(String(data: data, encoding: .utf8)!)
            
            
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
    

    func getParameterFrom(url: String, param: String) -> String? {

        guard let url = URLComponents(string: url) else { return nil }

        return url.queryItems?.first(where: { $0.name == param })?.value

    }



}
    
    

