//
//  PublicModel.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 11/05/2022.
//

import Foundation
struct User: Codable {
    let subscriptions: [Subscriptions]?
    let name: String
    let email: String
    let uid: String
    
}

struct Subscriptions: Codable {
    let title: String
}
