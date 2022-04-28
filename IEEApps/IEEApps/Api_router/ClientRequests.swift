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
    
    static func getPublicAnnouncements(completion: @escaping (PublicAnns?) -> Void) {
        sessionManager.request(APIRouter.getPublicAnnouncments).getDecodable { (response: AFDataResponse<PublicAnns>) in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    static func getAccessToken(client_id: String, client_secret: String, code: String, grant_type: String,  completion: @escaping (AuthModel?) -> Void) {
        sessionManager.request(APIRouter.getToken(grant_type: grant_type, client_id: client_id, client_secret: client_secret, code: code)).getDecodable { (response: AFDataResponse<AuthModel>) in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
