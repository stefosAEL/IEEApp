//
//  ClientRequestsRetrier.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 28/05/2022.
//

import Foundation
import Alamofire
import KeychainSwift
class ClientRequestsRetrier: Interceptor {
    let keychain = KeychainSwift()
    override var accessToken: String? {
        return DataContext.instance.accessToken

    }
    
    override func refreshTokens(completion: @escaping (Bool) -> ()) {
        guard !isRefreshing else { return }
        isRefreshing = true
        DataContext.instance.refreshToken { [weak self] (success) in
            self?.isRefreshing = false
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
}
