//
//  SaryHomeRemoteServiceManager.swift
//  Sary flagship iOS App
//
//  Created by islam on 05/03/2022.
//

import Foundation
import Moya
import RxSwift

protocol SaryHomeService {

    func getBanners() -> Single<ObjectResponse<[Banner]>>
    func getCategoriesGroup() -> Single<ObjectResponse<[Group]>>

}

class SaryHomeServiceManager: SaryHomeService {
    let provider = AppMoyaProvider<SaryHomeApi>(isMock: false)

    func getBanners() -> Single<ObjectResponse<[Banner]>> {
        return provider.rx
            .request(.getBanners)
            .map(ObjectResponse<[Banner]>.self)
            .catchError { error in
                throw error
            }
    }
    
    func getCategoriesGroup() -> Single<ObjectResponse<[Group]>> {
        return provider.rx
            .request(.getCategories)
            .map(ObjectResponse<[Group]>.self)
            .catchError { error in
                throw error
            }
    }
    

}
