//
//  RemoteOAuthClient.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 16/04/2022.
//

import Foundation

struct OAuthConfig {
    let authorizationUrl: URL
    let clientId: String
    let redirectUri: URL
    let responseType:String
    let scope: [String]
    let clientSecret: String
    
    
}

class RemoteOAuthClient: OAuthClient {
    
    struct AuthParms: Encodable {
        let client_id: String
        let redirect_uri: String
        let response_type: String
        let scope:String
     
    }
    
    
    private let config: OAuthConfig
    private let httpClient: HTTPClient
  
    init(config: OAuthConfig, httpClient: HTTPClient) {
        self.config = config
        self.httpClient = httpClient
    }
    
    func getAuthPageUrl(state clientId : String) -> URL? {
        let params = AuthParms(client_id: config.clientId,
                               redirect_uri: config.redirectUri.absoluteString,response_type: config.responseType,
                               scope: config.scope.joined(separator: ","))
        let httpRequest = HttpRequest(baseUrl: config.authorizationUrl,
                                      method: .get,
                                      params: params,
                                      headers: [:])
        return httpRequest.asURLRequest()?.url
    }
    
}
