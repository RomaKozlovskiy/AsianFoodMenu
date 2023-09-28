//
//  TabBarController.swift
//  AsianFoodMenu
//
//  Created by Роман Козловский on 24.09.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    var listImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabs()
    }
    
    private func configureTabs() {
        let vc1 = MenuViewController()
        let vc2 = SecondViewController()
        let vc3 = ThirdViewController()
        
        vc1.tabBarItem.image = UIImage(systemName: "list.bullet")
        vc2.tabBarItem.image = UIImage(systemName: "case")
        vc3.tabBarItem.image = UIImage(systemName: "info")
    
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        tabBar.tintColor = .yellow
        tabBar.backgroundColor = .gray
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
}
