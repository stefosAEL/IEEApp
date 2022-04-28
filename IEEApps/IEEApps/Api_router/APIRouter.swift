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
    case getToken(grant_type: String,client_id: String,client_secret: String,code: String)
    
    var baseURL: String? {
        switch self {
            case .getPublicAnnouncments:
                return "https://aboard.iee.ihu.gr//api"
            case .getToken:
                return "https://login.iee.ihu.gr"
            
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .getPublicAnnouncments:
                return .get
            case .getToken:
                return .post
        }
    }
    
    var path: String {
        switch self {
            case .getPublicAnnouncments:
                return "/announcements"
            case .getToken:
                return "/token"
        }
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .post:
            switch self {
                case .getPublicAnnouncments:
                    return JSONEncoding.default
                case .getToken:
                    return URLEncoding.default
                
            }
        default:
            return URLEncoding.queryString
        }
    }
    
    var headers: [String : String] {
        var headers = ["Content-Type" : "application/json"]
        switch self {
            case .getToken:
               
            headers["Content-Type"] = "application/x-www-form-urlencode"
            headers["Cookie"] = "connect.sid=s%3Axd_v-ikpMWEEHhw-QMJDT8B0hbFgl9Yl.9zywdEQreC5wdmSPD%2BA4Gq9Jc3xkris4a%2FrAnsUdnQE"
        case .getPublicAnnouncments:
            break
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
        case.getToken(let client_id, let client_secret, let code , let grant_type ):
            parameters = [
                "client_id" : client_id,
                "client_secret" : client_secret,
                "code" : code,
                "grant_type": grant_type
            ]
            
        }
    
        return try encoding.encode(request, with: parameters)
    }
    
    
}


