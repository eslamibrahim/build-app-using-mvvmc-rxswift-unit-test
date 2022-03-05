
import CoreData
import RxSwift
import UIKit

class AppCoordinator: Coordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow ) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        navigationToTabBar()
    }

    func navigationToTabBar() -> Observable<Void> {
        let rootCoordinator = TabBarCoordinator(window: self.window, parentCoo: self)
        return coordinate(to: rootCoordinator)
    }

    deinit {
        print(AppCoordinator.self)
    }
}


class TabBarCoordinator: Coordinator<Void>{
    
    private var window: UIWindow
    private let viewControllers: [UINavigationController]

    init(window: UIWindow , parentCoo: Coordinator<CoordinationResult>) {
        self.window = window
        self.viewControllers = HomeBarKind.items
            .map { (items) -> UINavigationController in
                let navigation = UINavigationController()
                navigation.setNavigationBarHidden(true, animated: false)
                navigation.tabBarItem.title = items.title
                navigation.tabBarItem.image = items.icon
                return navigation
            }
        super.init()
        self.parentCoo = parentCoo
    }

    override func start() -> Observable<Void> {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "AppHostTabbarViewController") as! AppHostTabbarViewController
        tabBarController.tabBar.isTranslucent = false
        tabBarController.viewControllers = viewControllers
        let coordinates = viewControllers.enumerated()
            .map { (offset, element) -> Observable<Void> in
                guard let items = HomeBarKind(rawValue: offset) else { return Observable.just(()) }
                switch items {
                case .dashboard:
                    let dashboardCordinator = AppDelegate.container.resolve(SaryHomeCoordinatoor.self, argument: element)
                    return coordinate(to: dashboardCordinator!)
                case .tab2:
                    let otherCordinator = AppDelegate.container.resolve(OtherTabsCoordinatoor.self, argument: element)
                    return coordinate(to: otherCordinator!)
                case .tab3:
                    let otherCordinator = AppDelegate.container.resolve(OtherTabsCoordinatoor.self, argument: element)
                    return coordinate(to: otherCordinator!)
                }
            }

        Observable.merge(coordinates)
            .subscribe()
            .disposed(by: disposeBag)

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

        return .never()
    }


}


class OtherTabsCoordinatoor: Coordinator<Void> {
    
    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    override func start() -> Observable<Void> {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "viewController")
        navigationController.setViewControllers([viewController], animated: true)
        return Observable.empty()
    }
    

}
