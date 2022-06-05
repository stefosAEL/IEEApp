//
//  SubscriptionsModel.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 27/05/2022.
//

import Foundation

struct Subscription: Codable {
    let pivot : Pivot?
    
    struct Pivot: Codable {
        let tagID: Int

        enum CodingKeys: String, CodingKey {
            case tagID = "tag_id"
        }
    }
}
