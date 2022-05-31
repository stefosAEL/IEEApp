//
//  DataContext.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 05/04/2022.
//

import Foundation
import KeychainSwift
class DataContext {
    static let instance = DataContext()
    let keychain = KeychainSwift()

    
    var publicAnnouncements: [PublicAnn] = []
    var logginAnnouncements: [PublicAnn] = []
    
    var grant_type : String = "authorization_code"
    var refresh_grant_type : String = "refresh_token"
    var page: Int = 1
    var page2: Int = 1
    var page3: Int = 1
    var code: String?
    var message:String?
    var accessToken: String = ""
    var refreshToken: String?
    
}


