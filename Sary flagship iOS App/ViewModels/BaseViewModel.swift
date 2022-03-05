//
//  BaseViewModel.swift
//  Sehatty
//
//  Created by Moneer Khallaf on 17/11/2020.
//  Copyright © 2020 Lean. All rights reserved.
//

import RxSwift
import RxCocoa

class BaseViewModel {
    let error = PublishSubject<Error>()
    let loading = BehaviorRelay<Bool?>(value: nil)
    let dispose = DisposeBag()
    
    init() {
        
    }
    
    func showLoadingInd() {
        if loading.value != true {
            loading.accept(true)
        }
    }
    
    func hideLoadingInd() {
        loading.accept(false)
    }
}
