//
//  OAuthClient.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 16/04/2022.
//
import Foundation

protocol OAuthClient {
    func getAuthPageUrl(state: String) -> URL?
    func exchangeCodeForToken(code: String,
                              completion: @escaping (Result<TokenBag, Error>) -> Void)
}

struct TokenBag {
    let accessToken: String
}

class OAuthService {
    enum OAthError: Error {
        case malformedLink
        case exchangeFailed
    }
    private let oauthClient: OAuthClient
    private var state: String?
    var onAuthenticationResult: ((Result<TokenBag, Error>) -> Void)?

    init(oauthClient: OAuthClient) {
        self.oauthClient = oauthClient
   }
    
    func getAuthPageUrl(state: String = UUID().uuidString) -> URL? {
        self.state = state
        return oauthClient.getAuthPageUrl(state: state)
    }
    
    func getParameterFrom(url: String, param: String) -> String? {

        guard let url = URLComponents(string: url) else { return nil }

        return url.queryItems?.first(where: { $0.name == param })?.value

    }

}

//MARK: - Private Methods
private extension OAuthService {
    func getCodeFromUrl(url: URL) -> String? {
        let code = self.getParameterFrom(url: url.absoluteString, param: "code")
        print(code ?? "ael")
        if let code = code {
            return code
        } else {
            return nil
        }
    }
}
