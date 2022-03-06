//
//  MockSaryHomeRepository.swift
//  Sary flagship iOS AppTests
//
//  Created by islam on 06/03/2022.
//

import Foundation
import RxSwift

class MockSaryHomeRepository : SaryHomeRepository{
    
    let saryHomeMockService : SaryHomeService
    init(saryHomeMockService : SaryHomeService) {
        self.saryHomeMockService = saryHomeMockService
    }
    
    func getBanners() -> Single<ObjectResponse<[Banner]>> {
        saryHomeMockService.getBanners()
    }
    
    func getCategoriesGroup() -> Single<ObjectResponse<[Group]>> {
        saryHomeMockService.getCategoriesGroup()
    }
    
    
}
