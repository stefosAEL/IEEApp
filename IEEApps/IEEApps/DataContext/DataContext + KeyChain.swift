//
//  DataContext + KeyChain.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 19/05/2022.
//

import Foundation
import KeychainSwift

extension DataContext {
    
    enum KeychainKey: String {
        case FORCE_RELOAD_PRIVATE_ANNOUNCEMENTS = "FORCE_RELOAD_PRIVATE_ANNOUNCEMENTS"
        case REMEMBER_TOKEN = "remember_token"
        case REMEMBER_REFRESH_TOKEN = "remember_refresh_token"


        var key: String {
            return self.rawValue
        }
    }
    
    var reloadMainTransaction: String {
        get {
            guard let reloadPrivate = keychain.get(KeychainKey.FORCE_RELOAD_PRIVATE_ANNOUNCEMENTS.key) else {
                return "false"
            }
            return reloadPrivate
        }
        set{
            keychain.set(newValue, forKey: KeychainKey.FORCE_RELOAD_PRIVATE_ANNOUNCEMENTS.key)
        }
    }
    var rememberToken: String {
        get {
            guard let rememberToken = keychain.get(KeychainKey.REMEMBER_TOKEN.key) else {
                return ""
            }
            return rememberToken
        }
        set{
            keychain.set(newValue, forKey: KeychainKey.REMEMBER_TOKEN.key)
        }
    }
    var rememberRefreshToken: String {
        get {
            guard let rememberRefreshToken = keychain.get(KeychainKey.REMEMBER_REFRESH_TOKEN.key) else {
                return ""
            }
            return rememberRefreshToken
        }
        set{
            keychain.set(newValue, forKey: KeychainKey.REMEMBER_REFRESH_TOKEN.key)
        }
    }
}
