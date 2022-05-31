//
//  SceneDelegate.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 27/03/2022.
//

import UIKit
import KeychainSwift
import WebKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    let dependencyContainer = AppDependencyContainer()
    var window: UIWindow?
    let keychain = KeychainSwift()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let mainVC = dependencyContainer.makeMainViewController()
        self.window = window
        window.frame = UIScreen.main.bounds
        let loggedIn = keychain.get(DataReloadEnum.FORCE_RELOAD_PRIVATE_ANNOUNCEMENTS.rawValue)
        if loggedIn == "true" {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let viewcontroller = storyBoard.instantiateViewController(withIdentifier: "PrivateAnnouncementsVC") as! PrivateAnnouncementsVC
            let navigationController = UINavigationController(rootViewController: viewcontroller)
            navigationController.modalPresentationStyle = .fullScreen
            window.rootViewController = navigationController
        } else {
            window.rootViewController = mainVC
        }
        
        window.makeKeyAndVisible()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let urlContext = URLContexts.first {
            let url = urlContext.url
            if let deepLink = DeepLink(url: url) {
                dependencyContainer.deepLinkHandler.handleDeepLinkIfPossible(deepLink: deepLink)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

