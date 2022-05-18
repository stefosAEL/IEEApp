//
//  APIRouter.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 05/04/2022.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {

    case getPublicAnnouncments(page:Int)
    case getLoginAnnouncments(page:Int)
    case getNotifications(page:Int,pageSize:Int)
    case getToken(code: String)
    case getUser
    
    var baseURL: String? {
        switch self {
            case .getPublicAnnouncments:
                return "https://aboard.iee.ihu.gr//api"
            case .getLoginAnnouncments:
                return "https://aboard.iee.ihu.gr//api"
            case .getNotifications:
                return "https://aboard.iee.ihu.gr//api/auth/user"
            case .getUser:
                return "https://aboard.iee.ihu.gr//api/auth"
            case .getToken:
                return"https://login.iee.ihu.gr"
           
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .getPublicAnnouncments:
                return .get
            case .getLoginAnnouncments:
                return .get
            case .getNotifications:
                return .get
            case .getToken:
                return .post
            case .getUser:
                return .get
            
        }
    }
    
    var path: String {
        switch self {
            case .getPublicAnnouncments:
                return "/announcements"
            case .getLoginAnnouncments:
                return "/announcements"
            case .getNotifications:
                return "/notifications"
            case .getToken:
                return "/token"
            case .getUser:
                return "/user"
            
        }
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .post:
            switch self {
                case .getPublicAnnouncments,
                    .getLoginAnnouncments,
                    .getNotifications,
                    .getUser:
                    return JSONEncoding.default
                case .getToken:
                    return URLEncoding.default
            }
        default:
            return URLEncoding.queryString
        }
    }
    
    var headers: [String : String] {
        let token = DataContext.instance.accessToken
        var headers = [
            "Content-Type": "application/json"
        ]

    switch self {
        case .getPublicAnnouncments:
            break
        case .getLoginAnnouncments:
            print(token)
            headers=["Authorization" :"Bearer \(String(describing: token))"]
        case .getNotifications:
            print(token)
            headers=["Authorization" :"Bearer \(String(describing: token))"]
        case .getUser:
            print(token)
            headers=["Authorization" :"Bearer \(String(describing: token))"]
        case .getToken:
            headers=["Content-Type" :"application/x-www-form-urlencoded"]
        }
        return headers
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url: URL = try (baseURL ?? "").asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        print(headers)
        var parameters: Parameters?
        
        switch self {
        case.getPublicAnnouncments:
            parameters = [:]
            parameters = ["page" : DataContext.instance.page]
        case .getLoginAnnouncments:
            parameters = [:]
            parameters = ["page" : DataContext.instance.page2]
        case .getNotifications:
            parameters = [:]
            parameters = ["page" : DataContext.instance.page3,
                          "pageSize": 10]
        case .getUser:
            parameters = [:]
        case .getToken(let code):
            parameters = [
                "code": code,
                "grant_type": "authorization_code",
                "client_id": "62408ef084b2a60fc0ba856c",
                "client_secret" : "4mtxqivi27efteqcmkgzc7v7ex97o8ak4qjggack3jo07lfzaq"
            ]
        }
        return try encoding.encode(request, with: parameters)
    }
    
    
}


