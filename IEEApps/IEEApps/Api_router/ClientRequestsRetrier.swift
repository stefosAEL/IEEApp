//
//  ClientRequestsRetrier.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 28/05/2022.
//

import Foundation
import Alamofire

class ClientRequestsRetrier: Interceptor {
    
    override var accessToken: String? {
        return DataContext.instance.accessToken
    }
    
    override func refreshTokens(completion: @escaping (Bool) -> ()) {
        guard !isRefreshing else { return }
        isRefreshing = true
        print("Refreshing")
        DataContext.instance.refreshToken { [weak self] (success) in
            self?.isRefreshing = false
            DispatchQueue.main.async {
                completion(success)
            }
        }
    }
}
