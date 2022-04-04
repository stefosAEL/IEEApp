//
//  PublicAnnsModel.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 02/04/2022.
//

import Foundation
struct PublicAnns: Decodable {
  let all: [PublicAnn]
  
  
  enum CodingKeys: String, CodingKey {
    case all = "data"
    
  }
}
