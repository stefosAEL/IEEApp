//
//  DeepLinkHandler.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 16/04/2022.
//

import Foundation

let scheme = "https://github.com/stefosAEL"

enum DeepLink: Hashable {
    case oAuth(URL)
    
    init?(url: URL) {
        let authLinkToDeepLink: (URL) -> DeepLink = { .oAuth($0) }
        
        let deepLinkMap: [String: (URL) -> DeepLink] = [
            "\(scheme)/IEEApp": authLinkToDeepLink
        ]
        
        let deepLink = deepLinkMap.first(where: { url.absoluteString.hasPrefix($0.key) })?.value
        
        switch deepLink {
        case .some(let urlToDeepLink):
            self = urlToDeepLink(url)
        default:
            return nil
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .oAuth:
            return hasher.combine(1)
        }
    }
    
    static func ==(lhs: DeepLink, rhs: DeepLink) -> Bool {
      return lhs.hashValue == rhs.hashValue
    }
}

class DeepLinkHandler {
    typealias DeeplinkCallback = (DeepLink) -> Void
    
    var callbackMap: [DeepLink: DeeplinkCallback] = [:]
    
    func addCallback(_ callback: @escaping DeeplinkCallback, forDeepLink deepLink: DeepLink) {
        callbackMap[deepLink] = callback
    }
    
    func handleDeepLinkIfPossible(deepLink: DeepLink) {
        guard let callback = callbackMap[deepLink] else { return  }
        
        callback(deepLink)
    }
}
