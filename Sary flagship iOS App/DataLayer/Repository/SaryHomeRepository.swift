//
//  SaryHomeRepository.swift
//  Sary flagship iOS App
//
//  Created by islam on 05/03/2022.
//

import Alamofire
import Foundation
import Moya
import RxSwift

protocol SaryHomeRepository {
    func getBanners() -> Single<ObjectResponse<[Banner]>>
    func getCategoriesGroup() -> Single<ObjectResponse<[Group]>>
}

class SaryHomeDataRepository: SaryHomeRepository {

    let disboseBag = DisposeBag()
    var remoteServices : SaryHomeService!
    
    init(remoteServices: SaryHomeService) {
        self.remoteServices = remoteServices
    }
    func getBanners() -> Single<ObjectResponse<[Banner]>> {
        remoteServices.getBanners()
    }
    
    func getCategoriesGroup() -> Single<ObjectResponse<[Group]>> {
        remoteServices.getCategoriesGroup()
    }
    
}
