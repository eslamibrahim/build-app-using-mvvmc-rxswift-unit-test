//
//  SaryHomeDashboardViewModel.swift
//  Sary flagship iOS App
//
//  Created by islam on 05/03/2022.
//

import Foundation
import RxRelay

class SaryHomeDashboardViewModel  : BaseViewModel{
    
    let repo : SaryHomeRepository
    var banners = BehaviorRelay<[Banner]>(value: [])
    var categoriesGroups = BehaviorRelay<[Group]>(value: [])
    
     init(repo : SaryHomeRepository) {
        self.repo = repo
    }
    
    func getBanners() {
        self.showLoadingInd()
        repo.getBanners().subscribe(onSuccess: { [weak self] res in
            self?.hideLoadingInd()
            self?.banners.accept(res.result ?? [])
        }, onError: {[weak self] err in
            self?.hideLoadingInd()
            self?.error.onNext(err )
        }).disposed(by: dispose)
    }
    
    func getCategoriesGroups() {
        self.showLoadingInd()
        repo.getCategoriesGroup().subscribe(onSuccess: { [weak self] res in
            self?.hideLoadingInd()
            self?.categoriesGroups.accept(res.result ?? [])
        }, onError: {[weak self] err in
            self?.hideLoadingInd()
            self?.error.onNext(err )
        }).disposed(by: dispose)
    }
    
}
