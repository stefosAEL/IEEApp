//
//  PublicAnnModel.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 02/04/2022.
//
import Alamofire

struct PublicAnn:Codable {
    //let teacher: String
    let title: String
    let body: String
    //  let event: String
    let dateTime: String
    let tags: Tags
}

enum CodingKeys: String, CodingKey {
   //case teacher="author.name"
   case title
   case body
   //case event="tags"
   case dateTime = "created_at"
 }

struct Tags:Codable {
    let title: String
}
