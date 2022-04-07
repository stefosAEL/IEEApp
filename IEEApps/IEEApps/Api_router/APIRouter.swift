//
//  APIRouter.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 05/04/2022.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {

    case getPublicAnnouncments
    
    var baseURL: String? {
        switch self {
            case .getPublicAnnouncments:
            return "https://aboard.iee.ihu.gr//api"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .getPublicAnnouncments:
                return .get
        }
    }
    
    var path: String {
        switch self {
            case .getPublicAnnouncments:
                return "/announcements"
        }
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .post:
            switch self {
                case .getPublicAnnouncments:
                    return JSONEncoding.default
            }
        default:
            return URLEncoding.queryString
        }
    }
    
    var headers: [String : String] {
        let headers = [
            "Content-Type": "application/json"
        ]
        return headers
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url: URL = try (baseURL ?? "").asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        var parameters: Parameters?
        
        switch self {
        case.getPublicAnnouncments:
            parameters = [:]
        }
    
        return try encoding.encode(request, with: parameters)
    }
    
    
}
