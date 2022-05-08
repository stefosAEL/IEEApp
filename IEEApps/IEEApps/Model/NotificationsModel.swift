//
//  NotificationsModel.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 07/05/2022.
//

import Foundation
struct Notifications: Codable {
  let data: [Notification]
  let meta : Metas?
}

struct Metas:Codable{
    let last_page:Int
}
