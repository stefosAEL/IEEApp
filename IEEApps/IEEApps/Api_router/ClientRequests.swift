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
    
}
