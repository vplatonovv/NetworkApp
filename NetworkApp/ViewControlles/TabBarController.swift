//
//  TabBarController.swift
//  NetworkApp
//
//  Created by Слава Платонов on 29.09.2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let controllers = tabBarController?.viewControllers {
//            for vc in controllers {
//                if vc == controllers.first {
//                    vc.tabBarItem.title = "Characters"
//                    vc.tabBarItem.image = UIImage(systemName: "person.fill")
//                } else if vc == controllers.last {
//                    vc.tabBarItem.title = "Episodes"
//                    vc.tabBarItem.image = UIImage(systemName: "video.fill")
//                }
//            }
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if let controllers = tabBarController?.viewControllers {
//            for vc in controllers {
//                if vc == controllers.first {
//                    tabBarItem.title = "Characters"
//                    tabBarItem.image = UIImage(systemName: "person.fill")
//                } else if vc == controllers.last {
//                    tabBarItem.title = "Episodes"
//                    tabBarItem.image = UIImage(systemName: "video.fill")
//                }
//            }
//        }
    }

}
