//
//  SaryHomeCoordinatoor.swift
//  Sary flagship iOS App
//
//  Created by islam on 05/03/2022.
//

import Foundation
import UIKit
import RxSwift


class SaryHomeCoordinatoor: Coordinator<Void> {
    
    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    override func start() -> Observable<Void> {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SaryHomeViewController") as! SaryHomeViewController
        //---------- I'm using R lib to access resources
        let viewModel = AppDelegate.container.resolve(SaryHomeDashboardViewModel.self)

        viewController.viewModel = viewModel
        navigationController.setViewControllers([viewController], animated: true)
       
        return Observable.empty()
    }
    


}

