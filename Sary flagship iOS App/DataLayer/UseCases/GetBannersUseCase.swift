//
//  GetBannersUseCase.swift
//  Sary flagship iOS App
//
//  Created by islam on 05/03/2022.
//

//import Foundation
//import RxSwift
//
//protocol GetBannersUseCaseProtocol {
//  
// func getBanners(complation @scaping :  PublishSubject<ObjectResponse<[Banner]>>? -> Void)
//    
//}
//
//class GetBannersUseCase : GetBannersUseCaseProtocol {
//    
//    let repo : SaryHomeRepository
//    
//    init(repo : SaryHomeRepository) {
//        self.repo = repo
//    }
//
//    func getBanners() {
//        repo.getBanners().subscribe(onSuccess: { res in
//
//            }, onError: { err in
//                
//                self.error.onNext(err as? ApiError)
//            }).disposed(by: dispose)
//    }
//    
//    
//}
