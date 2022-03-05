//
//  HomeBarKind.swift
//  Sehatty
//
//  Created by islam on 07/04/1442 AH.
//  Copyright © 1442 Lean. All rights reserved.
//

import Foundation
import UIKit

enum HomeBarKind: Int {
    case dashboard
    case tab2
    case tab3
    
    var title: String? {
        switch self {
        case .dashboard:
            // we will add localization here for ar or en like dashboard.localized
            return "المتجر"
        case .tab2:
            return "الطلبات"
        case .tab3:
            return "صفحتي"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .dashboard:
            return #imageLiteral(resourceName: "ic_home_tab.pdf")
        case .tab2:
            return #imageLiteral(resourceName: "ic_orders_tab.pdf")
        case .tab3:
            return #imageLiteral(resourceName: "ic_user_tab.pdf")
        }
    }
    
    var navigationController: UINavigationController {
        let navigation = UINavigationController()
        navigation.tabBarItem.title = self.title
        navigation.tabBarItem.image = self.icon
        return navigation
    }
}

extension RawRepresentable where RawValue == Int {
    static var itemCount: Int {
        var index = 0
        while Self(rawValue: index) != nil {
            index += 1
        }
        
        return index
    }
    
    static var items: [Self] {
        var items = [Self]()
        var index = 0
        while let item = Self(rawValue: index) {
            items.append(item)
            index += 1
        }
        
        return items
    }
}

class AppHostTabbarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateTabBarAppearance()
        delegate = self
    }

    func updateTabBarAppearance() {
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
    }

    // MARK: UITabbar Delegate

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
