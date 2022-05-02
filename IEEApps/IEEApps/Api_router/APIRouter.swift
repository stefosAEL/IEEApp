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
    case getLoginAnnouncments
    
    var baseURL: String? {
        switch self {
            case .getPublicAnnouncments:
                return "https://aboard.iee.ihu.gr//api"
            case .getLoginAnnouncments:
            return "https://aboard.iee.ihu.gr//api"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .getPublicAnnouncments:
                return .get
            case .getLoginAnnouncments:
                return .get
        }
    }
    
    var path: String {
        switch self {
            case .getPublicAnnouncments:
                return "/announcements"
            case .getLoginAnnouncments:
                return "/announcements"
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
            headers=["token" :"\(String(describing: token))"]
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
        }
        return try encoding.encode(request, with: parameters)
    }
    
    
}


