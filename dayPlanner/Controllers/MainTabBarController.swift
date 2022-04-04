//
//  ViewController.swift
//  dayPlanner
//
//  Created by Evgeniy on 01/04/2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()

        self.tabBar.backgroundColor = .white
       
    }
    
    func setupTabBar() {
        let plannerViewController = createNavigationController(viewController: PlannerViewController(), itemName: "Planner", itemImage: "calendar.badge.clock")
        let tasksViewController = createNavigationController(viewController: TasksViewController(), itemName: "Tasks", itemImage: "text.badge.checkmark")
        let contactsViewController = createNavigationController(viewController: ContactsViewController(), itemName: "Contacts", itemImage: "person.2.circle")
        
        viewControllers = [plannerViewController,tasksViewController, contactsViewController ]
    }
    
    func createNavigationController(viewController: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 0, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 5)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = item
        
        return navigationController
    }


}

