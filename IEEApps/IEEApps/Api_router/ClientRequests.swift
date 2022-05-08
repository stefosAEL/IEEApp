//
//  ClientRequests.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 05/04/2022.
//
import Foundation
import Alamofire

class ClientRequests {

    static let sessionManager: Session = {
        let policy = RetryPolicy()
        let sessMan = Session(interceptor: policy)
        return sessMan
    }()
    
    static func getPublicAnnouncements(page:Int , completion: @escaping (PublicAnns?) -> Void) {
        sessionManager.request(APIRouter.getPublicAnnouncments(page: page)).getDecodable { (response: AFDataResponse<PublicAnns>) in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    static func getLogginAnnouncements(page:Int, completion: @escaping (PublicAnns?) -> Void) {
        sessionManager.request(APIRouter.getLoginAnnouncments(page:page)).getDecodable { (response: AFDataResponse<PublicAnns>) in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    static func getNotifications(page:Int, completion: @escaping (Notifications?) -> Void) {
        sessionManager.request(APIRouter.getNotifications(page:page)).getDecodable { (response: AFDataResponse<Notifications>) in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    static func Logout(completion: @escaping (Logout?) -> Void) {
        sessionManager.request(APIRouter.LogOut).getDecodable { (response: AFDataResponse<Logout>) in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
