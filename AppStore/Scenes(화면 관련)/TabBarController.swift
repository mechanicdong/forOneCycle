//
//  TabBarController.swift
//  AppStore
//
//  Created by 이동희 on 2022/03/12.
//

import UIKit

class TabBarController: UITabBarController {
    //two tab init
    private lazy var todayViewController: UIViewController = {
        let viewController = TodayViewController()
        let tabBarItem = UITabBarItem(title: "Today", image: UIImage(systemName: "mail"), tag: 0)
        viewController.tabBarItem = tabBarItem
        return viewController
    }()
    
    private lazy var appViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: AppViewController())
        let tabBarItem = UITabBarItem(title: "App", image: UIImage(systemName: "square.stack.3d.up"), tag: 1)
        viewController.tabBarItem = tabBarItem
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [todayViewController, appViewController]
    }

}
