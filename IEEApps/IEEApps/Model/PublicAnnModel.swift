//
//  PublicAnnModel.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 02/04/2022.
//
import Alamofire

struct PublicAnn: Codable {
    let author: Teacher
    let title: String
    let body: String
    let created_at: String
    let tags: [Tags]
    let id: Int
}

struct Teacher: Codable {
    let name: String
}

struct Tags:Codable {
    let title: String
}


