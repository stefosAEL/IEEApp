//
//  AuthModel.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 26/04/2022.
//

import Foundation

struct AuthModel: Codable {
    let access_token: String
    let user: String
    let refresh_token: String
    let error:Error?
    
    struct Error:Codable{
        let code:Int?
    }
}
