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
    case getNotifications(page:Int)
    
    var baseURL: String? {
        switch self {
            case .getPublicAnnouncments:
                return "https://aboard.iee.ihu.gr//api"
            case .getLoginAnnouncments:
                return "https://aboard.iee.ihu.gr//api"
            case .getNotifications:
                return "https://aboard.iee.ihu.gr//api/auth/user"
           
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
            
        }
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .post:
            switch self {
                case .getPublicAnnouncments:
                    return JSONEncoding.default
                case .getLoginAnnouncments:
                    return JSONEncoding.default
                case .getNotifications:
                    return JSONEncoding.default
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
            parameters = ["page" : DataContext.instance.page3]
        }
        return try encoding.encode(request, with: parameters)
    }
    
    
}


