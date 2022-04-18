//
//  AppDependeciesContainer.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 16/04/2022.
//

import UIKit

class AppDependencyContainer {
    let deepLinkHandler = DeepLinkHandler()
    let tokenRepository = InMemoryTokenRepository()
    
    func makeMainViewController() -> UIViewController {
        let redirectUri = URL(string: "https://github.com/stefosAEL/IEEApp")!
        let oAuthConfig = OAuthConfig(authorizationUrl: URL(string: "https://login.iee.ihu.gr/authorization/")!,
                                      clientId: "62408ef084b2a60fc0ba856c",
                                      redirectUri: redirectUri,
                                      responseType: "code",
                                      scope:["announcements","profile","notifications","refresh_token","edit_notifications"],
                                      tokenUrl: URL(string: "https://login.iee.ihu.gr/token")!,
                                      clientSecret: "yourClientSecret")
                                      
        let oAuthClient = RemoteOAuthClient(config: oAuthConfig, httpClient: HTTPClient())
        let oAuthService = OAuthService(oauthClient: oAuthClient, tokenRepository: tokenRepository)
        let deepLinkCallback: (DeepLink) -> Void = { deepLink in
            if case .oAuth(let url) = deepLink {
                oAuthService.exchangeCodeForToken(url: url)
            }
        }
        deepLinkHandler.addCallback(deepLinkCallback, forDeepLink: DeepLink(url: redirectUri)!)
        let loginVC = MainViewController(oAuthService: oAuthService, makeHomeViewController: makeHomeViewController)
        let navigationController = UINavigationController(rootViewController: loginVC)
        return navigationController
    }
    
    func makeHomeViewController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let repoVC = UIViewController()
        let repoTabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "repos"), tag: 0)
        repoTabBarItem.imageInsets = UIEdgeInsets(top: 15, left: 0, bottom: -15, right: 0)
        repoVC.tabBarItem = repoTabBarItem
        
        let profileVC = UIViewController()
        let profileTabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "profile"), tag: 1)
        profileTabBarItem.imageInsets = UIEdgeInsets(top: 15, left: 0, bottom: -15, right: 0)
        profileVC.tabBarItem = profileTabBarItem
        
        tabBarController.viewControllers = [repoVC, profileVC].map { UINavigationController(rootViewController: $0)}
        
        return tabBarController
    }

}
