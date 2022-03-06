//
//  MockSaryHomeServicesManager.swift
//  Sary flagship iOS AppTests
//
//  Created by islam on 06/03/2022.
//

import Foundation
import Moya
import RxSwift


class MockSaryHomeServicesManager: SaryHomeService {
    
    let mockProvider = AppMoyaProvider<SaryHomeApi>(isMock: true)

    
    func getBanners() -> Single<ObjectResponse<[Banner]>> {
        return mockProvider.rx
            .request(.getBanners)
            .map(ObjectResponse<[Banner]>.self)
            .catchError { error in
                throw error
            }
    }
    
    func getCategoriesGroup() -> Single<ObjectResponse<[Group]>> {
        return mockProvider.rx
            .request(.getCategories)
            .map(ObjectResponse<[Group]>.self)
            .catchError { error in
                throw error
            }
    }
    
    
}

