//
//  AppDelegate.swift
//  Sary flagship iOS App
//
//  Created by islam on 02/03/2022.
//

import UIKit
import RxCocoa
import RxSwift
import Swinject
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static let container = Container()
    var appCoordinator: AppCoordinator?
    let disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AppDelegate.container.registerDependencies()
        setupRootView()
        return true
    }

    func setupRootView() {
        appCoordinator = AppCoordinator(window: UIApplication.shared.keyWindow ?? UIWindow(frame: UIScreen.main.bounds))
        appCoordinator?.start()
            .subscribe()
            .disposed(by: disposeBag)
    }

    // MARK: UISceneSession Lifecycle

}

