//
//  DataContext.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 05/04/2022.
//

import Foundation

class DataContext {
    static let instance = DataContext()
    
    var publicAnnouncements: [PublicAnn] = []
    var logginAnnouncements: [PublicAnn] = []
    
    var code: String?
    var accessToken: String = ""
    var refreshToken: String?
    
}


