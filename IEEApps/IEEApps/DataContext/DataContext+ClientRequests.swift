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
    
    func getNotifications(page:Int ,completion: @escaping (Notifications?)-> Void) {
        ClientRequests.getNotifications(page:page, completion: { notifications in
            guard let notifications = notifications else {
                completion(nil)
                return
            }
            completion(notifications)
        })
    }
    func getUsers(completion: @escaping (Users?)-> Void) {
        ClientRequests.getUsers(completion: { users in
            guard let users = users else {
                completion(nil)
                return
            }
            completion(users)
        })
    }
    func getToken(code: String, completion: @escaping (AuthModel?)-> Void) {
        ClientRequests.getToken(code: code, completion: { authModel in
            guard let authModel = authModel else {
                completion(nil)
                return
            }
            completion(authModel)
        })
    }
    
    func refreshToken(completion: @escaping (Bool) -> Void) {
        guard let refreshToken = refreshToken else {
            completion(false)
            return
        }
        ClientRequests.refreshToken(refreshToken: refreshToken) {[weak self] (authModel) in
            guard let authModel = authModel else {
                completion(false)
                return
            }
            self?.refreshToken = authModel.refresh_token
            completion(true)
        }
    }
    
    func getTags(completion: @escaping (Tag?)-> Void) {
        ClientRequests.getTags(completion: { tags in
            guard let tags = tags else {
                completion(nil)
                return
            }
            completion(tags)
        })
    }
    
    func getSubscriptions(completion: @escaping ([Subscription]?)-> Void) {
        ClientRequests.getSubscriptions(completion: { subs in
            guard let subs = subs else {
                completion(nil)
                return
            }
            completion(subs)
        })
    }

}
