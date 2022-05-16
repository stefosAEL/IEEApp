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
    let button = UIButton(frame: CGRect(x: 70, y: 04, width: 44, height: 44))
    

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
                print(code)
                authModel = getToken(code: code)
                DataContext.instance.code = code
                DataContext.instance.refreshToken = authModel?.refresh_token
                DataContext.instance.accessToken = authModel?.access_token ?? "nill"
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let viewcontroller = storyBoard.instantiateViewController(withIdentifier: "PrivateAnnouncementsVC")
                viewcontroller.modalPresentationStyle = .fullScreen
                present(viewcontroller, animated: true, completion: nil)
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

    func getToken(code: String) -> AuthModel{
        let semaphore = DispatchSemaphore (value: 0)
        var decodedResponse :AuthModel?
        let parameters = "grant_type=authorization_code&client_id=62408ef084b2a60fc0ba856c&client_secret=4mtxqivi27efteqcmkgzc7v7ex97o8ak4qjggack3jo07lfzaq&code=\(code)"
        let postData =  parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: "https://login.iee.ihu.gr/token")!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
            let cookieStore = HTTPCookieStorage.shared
            for cookie in cookieStore.cookies ?? [] {
                cookieStore.deleteCookie(cookie)
            }
            decodedResponse = try! JSONDecoder().decode(AuthModel.self, from: data)
            print(String(data: data, encoding: .utf8)!)
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        return decodedResponse!
    }
    

    func getParameterFrom(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }

    
    @objc func ratingButtonTapped(){
        self.dismiss(animated: true, completion: nil)
    }



}
    
    

