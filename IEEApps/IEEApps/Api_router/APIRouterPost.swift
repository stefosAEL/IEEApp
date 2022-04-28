//
//  APIRouterPost.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 27/04/2022.
//

import Foundation
import Alamofire
enum APIRouterPost: URLRequestConvertible {

    
    case getToken(grant_type: String,client_id: String,client_secret: String,code: String)
    
    var baseURL: String? {
        switch self {
            case .getToken:
                return "https://login.iee.ihu.gr"
            
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .getToken:
                return .post
        }
    }
    
    var path: String {
        switch self {
            case .getToken:
                return "/token"
        }
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .post:
            switch self {
                case .getToken:
                    return URLEncoding.httpBody            }
        default:
            return URLEncoding.queryString
        }
    }
    
    var headers: [String : String] {
        var headers = ["Content-Type" : "application/x-www-form-urlencoded"]
         headers["connect.sid=s%3AfcIarDZSXo7WuQc_sclVGOlJ-VZxIo6V.XprPWEQKtmQHXcxGh3zNkyWPIE7t9D%2F6xvLgF99wPiI"] = "Cookie"
      
        
    
        return headers
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url: URL = try (baseURL ?? "").asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        var parameters: Parameters?
        
        switch self {
        case.getToken(let client_id, let client_secret, let code , let grant_type ):
            parameters = [:]
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



