//
//  LogginAnns.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 30/04/2022.
//

import Foundation
struct LogginAnns: Codable {
    let data: [PublicAnn]
    let meta : Meta?
  }

  struct Meta:Codable{
      let last_page:Int
  }
