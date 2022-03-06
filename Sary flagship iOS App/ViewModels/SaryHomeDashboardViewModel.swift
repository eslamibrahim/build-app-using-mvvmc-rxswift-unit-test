//
//  SaryHomeDashboardViewModel.swift
//  Sary flagship iOS App
//
//  Created by islam on 05/03/2022.
//

import Foundation
import RxSwift
import RxCocoa

typealias SaryHomeTableViewItemsData = (banners : [Banner]? , categoriesGroups : Group?)
class SaryHomeDashboardViewModel  : BaseViewModel{
    
    let repo : SaryHomeRepository
    var banners = BehaviorRelay<[Banner]>(value: [])
    var categoriesGroups = BehaviorRelay<[Group]>(value: [])
    var tableViewItemsData = BehaviorRelay<[SaryHomeTableViewItemsData]>(value : [])
    var loadHomeData = BehaviorRelay<Bool>(value: false)
    var didRefreshRootTable = BehaviorRelay<Bool?>(value : nil)

     init(repo : SaryHomeRepository) {
        self.repo = repo
    }
    
    func getSaryHomeUIInfo() {
        
        let bannersInfo = repo.getBanners()
        let categoriesGroup = repo.getCategoriesGroup()
        let zipped = Observable.zip(bannersInfo.asObservable(), categoriesGroup.asObservable())

        loadHomeData
            .do(onNext: { [unowned self] _ in self.showLoadingInd()})
            .flatMap { _ in zipped.materialize() }
            .do(onNext: { [unowned self] _ in  self.hideLoadingInd() })
            .subscribe(onNext: { [unowned self] allDataEvent in
                switch allDataEvent {
                case let .next((bannersResponse, categoriesResponse)):
                    self.hideLoadingInd()
                    self.banners.accept(bannersResponse.result ?? [])
                    self.categoriesGroups.accept(categoriesResponse.result ?? [])
                    self.buildTableViewItemsData()
                case let .error(error):
                    self.error.onNext(error)
                case .completed: break
                }
            }).disposed(by: dispose)
    }
    
    func buildTableViewItemsData(){
        var items = [SaryHomeTableViewItemsData]()
        items.append((banners : banners.value , categoriesGroups :nil))
        _ = categoriesGroups.value.map({ group in
            items.append((banners : nil, categoriesGroups :group))
        })
        self.tableViewItemsData.accept(items)
    }
    
    
}
