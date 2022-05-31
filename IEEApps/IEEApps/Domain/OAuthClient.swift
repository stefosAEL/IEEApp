//
//  OAuthClient.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 16/04/2022.
//
import Foundation

protocol OAuthClient {
    func getAuthPageUrl(state: String) -> URL?
    
}

class OAuthService {
    enum OAthError: Error {
        case malformedLink
        case exchangeFailed
    }
    private let oauthClient: OAuthClient
    private var state: String?

    init(oauthClient: OAuthClient) {
        self.oauthClient = oauthClient
   }
    
    func getAuthPageUrl(state: String = UUID().uuidString) -> URL? {
        self.state = state
        return oauthClient.getAuthPageUrl(state: state)
    }
    

}

