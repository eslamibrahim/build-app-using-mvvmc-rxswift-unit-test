//
//  SaryHomeRemoteServices.swift
//  Sary flagship iOS App
//
//  Created by islam on 05/03/2022.
//


import Alamofire
import Foundation
import Moya
import RxSwift

class AppMoyaProvider<T: TargetType>: MoyaProvider<T> {
    init(isMock: Bool? = false) {
        
        let sessionManager = DefaultAlamofireManager.sharedManager

        
        #if DEBUG
        let loggingPlugin = NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter), logOptions: .verbose))
        
        if isMock ?? false {
            super.init(
                stubClosure: AppMoyaProvider.delayedStub(3),
                session: sessionManager,
                plugins: [loggingPlugin])
        } else {
            super.init(session: sessionManager, plugins: [loggingPlugin])
        }
        #else
        super.init(session: sessionManager)
        #endif
    }
}

class MockAppMoyaProvider<T: TargetType>: MoyaProvider<T> {
    init() {
        super.init(stubClosure: MoyaProvider.delayedStub(3),
                   plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData:
                           JSONResponseDataFormatter),
                       logOptions: .verbose))])
    }
}

class DefaultAlamofireManager: Session {
    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 60 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireManager(configuration: configuration)
    }()
}

extension Reactive where Base: MoyaProviderType {
    func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
        return getRequest(token, callbackQueue: callbackQueue)
            .filterSuccessfulStatusCodes()
    }
    
    func getRequest(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
        return Single.create { [weak base] single in
            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    single(.success(response))
                case let .failure(error):
                    single(.error(error))
                }
            }
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
}


func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}
