//
//  DataRequest+Processing.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 05/04/2022.
//

import Foundation

import Foundation
import Alamofire

extension DataRequest {
   @discardableResult
    public func getDecodable<T: Decodable>(showErrorAlert: Bool = true, of type: T.Type = T.self, queue: DispatchQueue = .main, dataPreprocessor: DataPreprocessor = DecodableResponseSerializer<T>.defaultDataPreprocessor, decoder: DataDecoder = JSONDecoder(), emptyResponseCodes: Set<Int> = DecodableResponseSerializer<T>.defaultEmptyResponseCodes, emptyRequestMethods: Set<HTTPMethod> = DecodableResponseSerializer<T>.defaultEmptyRequestMethods, completionHandler: @escaping (AFDataResponse<T>) -> Void) -> Self {
        var url: String? {
            if let convertibleURL = convertible.urlRequest?.url?.absoluteString {
                return convertibleURL
            }
            return request?.url?.absoluteString
        }
        return responseDecodable(of: type, queue: queue, dataPreprocessor: dataPreprocessor, decoder: decoder, emptyResponseCodes: emptyResponseCodes, emptyRequestMethods: emptyRequestMethods)  { (response) in
            completionHandler(response)
        }
    }
    
    @discardableResult
    public func getResponse(showErrorAlert: Bool = true, queue: DispatchQueue = .main, completionHandler: @escaping (AFDataResponse<Data?>) -> Void) -> Self {
        var url: String? {
            if let convertibleURL = convertible.urlRequest?.url?.absoluteString {
                return convertibleURL
            }
            return request?.url?.absoluteString
        }
        return response(queue: queue, completionHandler: { (response) in
            if let error = response.error {
                print(error)
//                RequestPostProcessor.processResponse(response.data, error: error, url: url, showErrorAlert: showErrorAlert)
            }
            completionHandler(response)
        })
    }
    
//    @discardableResult
//    public func getJSON(showErrorAlert: Bool = true, queue: DispatchQueue = .main, dataPreprocessor: DataPreprocessor = JSONResponseSerializer.defaultDataPreprocessor, emptyResponseCodes: Set<Int> = JSONResponseSerializer.defaultEmptyResponseCodes, emptyRequestMethods: Set<HTTPMethod> = JSONResponseSerializer.defaultEmptyRequestMethods, options: JSONSerialization.ReadingOptions = .allowFragments, completionHandler: @escaping (AFDataResponse<Any>) -> Void) -> Self {
//        var url: String? {
//            if let convertibleURL = convertible.urlRequest?.url?.absoluteString {
//                return convertibleURL
//            }
//            return request?.url?.absoluteString
//        }
//        return responseJSON(queue: queue, dataPreprocessor: dataPreprocessor, emptyResponseCodes: emptyResponseCodes, emptyRequestMethods: emptyRequestMethods, options: options) {(response) in
//            if let error = response.error {
//                print(error)
////                RequestPostProcessor.processResponse(response.data, error: error, url: url, showErrorAlert: showErrorAlert)
//            }
//            completionHandler(response)
//        }
//    }
}
