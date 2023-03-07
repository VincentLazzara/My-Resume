//
//  MainTabController.swift
//  Vincent Lazzara
//
//  Created by Vinny Lazzara on 3/2/23.
//

import UIKit

class MainTabController: UITabBarController {

    //MARK: Lifecrycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewControllers()

    }
    func configureUI() {
        view.backgroundColor = .black
        tabBar.backgroundColor = .black
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.tintColor = .cyan
    }
    
//MARK: -Helpers
    
    func configureViewControllers() {
         
        let nav1 = templateNavigationController(image: UIImage(named: "user.png")!, rootViewController: AboutViewController())
        nav1.title = "About"
        
        addChild(nav1)
        
        let nav2 = templateNavigationController(image: UIImage(named: "envelope.png")!, rootViewController: ContactViewController())
        nav2.title = "Contact"

        let nav3 = templateNavigationController(image: UIImage(named: "app-store.png")!, rootViewController: ProjectsViewController())
        nav3.title = "Projects"

        let nav4 = templateNavigationController(image: UIImage(named: "coding.png")!, rootViewController: ExamplesViewController())
        nav4.title = "UI Examples"
        
        let font = UIFont(name: "CourierNewPS-BoldMT", size: 12)
           let attributes = [NSAttributedString.Key.font: font]
           UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)

        viewControllers = [nav1, nav3, nav4, nav2]
        
    }

    func templateNavigationController(image: UIImage, rootViewController: UIViewController) -> UINavigationController {
        //Asks for image and rootViewController, and outputs a navigation controller to use in the viewControllers
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        return nav
    }
    
    


}
