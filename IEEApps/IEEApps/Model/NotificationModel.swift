//
//  NotificationsModel.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 07/05/2022.
//

import Foundation
struct Notification: Codable {
    let data : Datas?
    let created_at:String
}

struct Datas:Codable{
    let type: String
    let user: String
}
