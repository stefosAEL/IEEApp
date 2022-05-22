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
}
