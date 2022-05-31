//
//  InMemoryTokenRepository.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 16/04/2022.
//

import Foundation

class InMemoryTokenRepository: TokenRepository {
    private var tokenBag: TokenBag?
    
    func getToken() -> TokenBag? { tokenBag }
    
    func setToken(tokenBag: TokenBag?) throws { self.tokenBag = tokenBag }
    
    func resetToken() throws { tokenBag = nil }
}
