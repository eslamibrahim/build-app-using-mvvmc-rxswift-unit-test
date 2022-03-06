//
//  Sary_flagship_iOS_AppTests.swift
//  Sary flagship iOS AppTests
//
//  Created by islam on 02/03/2022.
//

import XCTest
import RxSwift
@testable import Sary_flagship_iOS_App

class SaryHomeDashboardViewModelTest : XCTestCase {

    let viewModel = SaryHomeDashboardViewModel(repo : MockSaryHomeRepository(saryHomeMockService: MockSaryHomeServicesManager()))
    let dispose = DisposeBag()
    override func setUp() {
        
    }
    
    func testGetBannarsSuccess() {
        viewModel.repo.getBanners()
            .subscribe(onSuccess: { res in
                XCTAssertFalse(res.status ?? false)
                XCTAssert(res.result?.count != 0)
            }, onError: { err in
                XCTAssertFalse(false)
            }).disposed(by: dispose)
    }
    
    func testGetCategoriesSuccess() {
        viewModel.repo.getCategoriesGroup()
            .subscribe(onSuccess: { res in
                XCTAssertFalse(res.status ?? false)
                XCTAssert(res.result?.count != 0)
            }, onError: { err in
                XCTAssertFalse(false)
            }).disposed(by: dispose)
    }
    

}
