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
    private let tokenRepository: TokenRepository
    private var state: String?
    var onAuthenticationResult: ((Result<TokenBag, Error>) -> Void)?

    init(oauthClient: OAuthClient, tokenRepository: TokenRepository) {
        self.oauthClient = oauthClient
        self.tokenRepository = tokenRepository
    }
    
    func getAuthPageUrl(state: String = UUID().uuidString) -> URL? {
        self.state = state
        return oauthClient.getAuthPageUrl(state: state)
    }
    
    func getParameterFrom(url: String, param: String) -> String? {

        guard let url = URLComponents(string: url) else { return nil }

        return url.queryItems?.first(where: { $0.name == param })?.value

    }
    func exchangeCodeForToken(url: URL) {
        guard let code = getCodeFromUrl(url: url) else {
            onAuthenticationResult?(.failure(OAthError.malformedLink))
            return
        }
        
        oauthClient.exchangeCodeForToken(code: code) { [weak self] result in
            switch result {
            case .success(let tokenBag):
                try? self?.tokenRepository.setToken(tokenBag: tokenBag)
                self?.onAuthenticationResult?(.success(tokenBag))
            case .failure:
                self?.onAuthenticationResult?(.failure(OAthError.exchangeFailed))
            }
        }
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
