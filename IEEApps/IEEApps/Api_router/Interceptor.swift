//
//  Interceptor.swift
//  IEEApps
//
//  Created by Stefanos Kafkalias on 28/05/2022.
//

import Foundation
import Alamofire

class Interceptor: RequestInterceptor {
    typealias RefreshCompletion = (_ succeeded: Bool) -> Void
    
    private let lock = NSLock()
    
    var isRefreshing = false
    
    var accessToken: String? {
        return nil
    }
    private var requestsToRetry: [(RetryResult)->Void] = []
    // MARK: RequestRetrier
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("ERROR:", error, request.request?.url, request.retryCount)
        lock.lock() ; defer { lock.unlock() }
        if
            let statusCode = (request.task?.response as? HTTPURLResponse)?.statusCode,
            [401, 403].contains(statusCode)
        {
            requestsToRetry.append(completion)
            if !isRefreshing {
                print(request.retryCount)
                initiateRefresh(with: statusCode, session: session)
            }
        } else {
            completion(.doNotRetry)
        }
    }
    
    // MARK: RequestAdapter
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        let reachable = NetworkReachabilityManager()?.isReachable ?? false
        if !reachable{
            completion(.failure(RequestError.noInternet))
            return
        }
        var urlRequestToSend = urlRequest
        if accessToken != nil {
            urlRequestToSend.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        completion(.success(urlRequestToSend))
    }
    
    // MARK: - Private
    private func initiateRefresh(with statusCode: Int, session: Session) {
        let completion: RefreshCompletion = {[weak self] (succeeded) in
            self?.lock.lock(); defer { self?.lock.unlock() }
            if succeeded {
                self?.requestsToRetry.forEach({$0(.retry)})
            } else {
                session.cancelAllRequests()
                self?.requestsToRetry.removeAll()
            }
        }
        refreshTokens(completion: completion)
    }
    
    func refreshTokens(completion: @escaping (Bool)->()) {}
    
}

enum RequestError: Error {
    case noInternet
    case unknown
}

extension RequestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No Internet"
        case .unknown:
            return "Unknown Error"
        }
    }
}
