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
        let policy = ClientRequestsRetrier()
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
    static func getUsers(completion: @escaping (Users?) -> Void) {
        sessionManager.request(APIRouter.getUser).getDecodable { (response: AFDataResponse<Users>) in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getToken(code: String, completion: @escaping (AuthModel?) -> Void) {
        sessionManager.request(APIRouter.getToken(code: code)).getDecodable { (response: AFDataResponse<AuthModel>) in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func refreshToken(refreshToken: String, completion: @escaping (AuthModel?) -> Void) {
        sessionManager.request(APIRouter.refreshToken(refreshToken: refreshToken)).getDecodable { (response: AFDataResponse<AuthModel>) in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure:
                completion(nil)
            }
        }
    }
    
    static func getTags(completion: @escaping (Tag?) -> Void) {
        sessionManager.request(APIRouter.getTags).getDecodable { (response: AFDataResponse<Tag>) in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getSubscriptions(completion: @escaping ([Subscription]?) -> Void) {
        sessionManager.request(APIRouter.getTags).getDecodable { (response: AFDataResponse<[Subscription]>) in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
