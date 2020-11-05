////
////  NavigationBaseMenuBarController.swift
////  Fit5140_ChatBot
////
////  Created by Naureen Mukri on 5/11/20.
////  Copyright © 2020 Monash University. All rights reserved.
////
//
//import UIKit
//
//class NavigationBaseMenuBarController: UITabBarController {
//    
//    var customTabBar: TabNavigationMenu!
//    var tabBarHeight: CGFloat = 67.0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.loadTabBar()
//        // Do any additional setup after loading the view.
//    }
//    
//    
//    
//    func loadTabBar() {
//         // We'll create and load our custom tab bar here
//        let tabItems: [TabItem] = [.profile, .chat, .home, .map, .symptoms]
//        self.setupCustomTabBar(tabItems) { (controllers) in
//        self.viewControllers = controllers
//      }
//      self.selectedIndex = 0 // default our selected index to the first item
//           
//        }
//    func setupCustomTabBar(_ menuItems: [TabItem], completion: @escaping ([UIViewController]) -> Void) {
//    // handle creation of the tab bar and attach touch event listeners
//        let frame = tabBar.frame
//        var controllers = [UIViewController]()
//        // hide the tab bar
//        tabBar.isHidden = true
//        self.customTabBar = TabNavigationMenu(menuItems: items, frame: frame)
//        self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
//        self.customTabBar.clipsToBounds = true
//        self.customTabBar.itemTapped = self.changeTab
//        // Add it to the view
//        self.view.addSubview(customTabBar)
//        // Add positioning constraints to place the nav menu right where the tab bar should be
//        NSLayoutConstraint.activate([
//            self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
//            self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
//            self.customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
//            self.customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight), // Fixed height for nav menu
//            self.customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
//        ])
//        for i in 0 ..< items.count {
//            controllers.append(items[i].viewController) // we fetch the matching view controller and append here
//        }
//        self.view.layoutIfNeeded() // important step
//        completion(controllers) // setup complete. handoff here
//        }
//    func changeTab(tab: Int) {
//            self.selectedIndex = tab
//        }
//    
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
