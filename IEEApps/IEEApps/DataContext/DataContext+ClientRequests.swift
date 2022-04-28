//
//  DataContext+ClientRequests.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 05/04/2022.
//

import Foundation

extension DataContext {
    
    func getAnnouncemnets(completion: @escaping (PublicAnns?)-> Void) {
        ClientRequests.getPublicAnnouncements(completion: { publicAnns in
            guard let publicAnns = publicAnns else {
                completion(nil)
                return
            }
            completion(publicAnns)
        })
    }
    
    func getAccessToken(client_id: String, client_secret: String, code: String, grant_type: String, completion: @escaping (AuthModel?)-> Void) {
        ClientRequests.getAccessToken(client_id: client_id, client_secret: client_secret, code: code, grant_type: grant_type, completion: { auth in
            guard let auth = auth else {
                completion(nil)
                return
            }
            self.accessToken = auth.access_token
            self.refreshToken = auth.refresh_token
            
            completion(auth)
        })
    }
    
}
