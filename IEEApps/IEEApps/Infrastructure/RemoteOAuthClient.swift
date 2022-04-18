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
    let tokenUrl: URL
    let clientSecret: String
    
    
}
//http://your-redirect-uri?code=CODE
//http://your-redirect-uri?error=access_denied&error_reason=user_denied&error_description=Permission+Denied
//https://login.iee.ihu.gr/authorization/?client_id=" + CLIENT_ID + "&redirect_uri=" + RESPONSE_URL + //"&response_type=code&scope=announcements,profile,notifications,refresh_token,edit_mail,edit_password,edit_profile,edit_notifications"
class RemoteOAuthClient: OAuthClient {
    
    struct AuthParms: Encodable {
        let client_id: String
        let redirect_uri: String
        let response_type: String
        let scope:String
     
    }
    
    struct TokenParams: Encodable {
        let client_id: String
        let client_secret: String
        let code: String
        let redirect_uri: String
        
    }
    
    struct TokenResponse: Decodable {
        let accessToken: String
        
        private enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
        }
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
    
    func exchangeCodeForToken(code: String, state: String, completion: @escaping (Result<TokenBag, Error>) -> Void) {
        let params = TokenParams(client_id: config.clientId,
                                 client_secret: config.clientSecret,
                                 code: code,
                                 redirect_uri: config.redirectUri.absoluteString)
        let httpRequest = HttpRequest(baseUrl: config.tokenUrl,
                                      method: .get,
                                      params: params,
                                      headers: ["Accept": "application/json"])
        httpClient.performRequest(request: httpRequest) { (result: Result<TokenResponse, HTTPClient.RequestError>) in
            switch result {
            case .success(let response):
                completion(.success(TokenBag(accessToken: response.accessToken)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
