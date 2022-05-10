//
//  DataContext+ClientRequests.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 05/04/2022.
//

import Foundation

extension DataContext {
    
    func getAnnouncemnets(page:Int,completion: @escaping (PublicAnns?)-> Void) {
        ClientRequests.getPublicAnnouncements(page:page ,completion: { publicAnns in
            guard let publicAnns = publicAnns else {
                completion(nil)
                return
            }
            completion(publicAnns)
        })
    }
    
    func getLoggInAnnouncemnets(page:Int,completion: @escaping (PublicAnns?)-> Void) {
        ClientRequests.getLogginAnnouncements(page:page, completion: { logginAnns in
            guard let logginAnns = logginAnns else {
                completion(nil)
                return
            }
            completion(logginAnns)
        })
    }
    
    func getNotifications(page:Int,completion: @escaping (Notifications?)-> Void) {
        ClientRequests.getNotifications(page:page, completion: { notifications in
            guard let notifications = notifications else {
                completion(nil)
                return
            }
            completion(notifications)
        })
    }

}
