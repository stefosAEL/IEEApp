//
//  PublicAnnsModel.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 02/04/2022.
//

import Foundation
struct PublicAnns: Codable {
  let data: [PublicAnn]
  let meta : Meta?
}

struct Meta:Codable{
    let last_page:Int
}
