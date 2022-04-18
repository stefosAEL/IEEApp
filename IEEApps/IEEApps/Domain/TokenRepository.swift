//
//  TokenRepository.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 16/04/2022.
//

import Foundation
protocol TokenRepository {
    func getToken() -> TokenBag?
    func setToken(tokenBag: TokenBag?) throws
    func resetToken() throws
}
