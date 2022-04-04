//
//  GETPublicAnn.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 02/04/2022.
//

import Foundation
import Alamofire
extension MainViewController{
            func fetchPublicAnn(){
            let headers :HTTPHeaders=[.contentType("application/json")]
            let request = AF.request("https://aboard.iee.ihu.gr//api/announcements",headers: headers)
                request.responseDecodable(of: PublicAnns.self) { (response) in
                    guard let publicAnns = response.value else { return }
                    print(publicAnns.all[0].body)
                }
          }
        }




