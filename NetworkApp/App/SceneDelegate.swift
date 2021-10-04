//
//  SceneDelegate.swift
//  NetworkApp
//
//  Created by Слава Платонов on 24.09.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var navigation = UINavigationController()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let charactercVc = CharactersViewController()
        let seasonsVc = SViewController()
        
        let tabBarVc = UITabBarController()
        tabBarVc.setViewControllers([charactercVc, seasonsVc], animated: false)
        navigation = UINavigationController(rootViewController: tabBarVc)
        navigation.navigationBar.prefersLargeTitles = true
        tabBarVc.title = "Breaking Bad"
        
        if let controllers = tabBarVc.viewControllers {
            for vc in controllers {
                if vc == controllers.first {
                    vc.tabBarItem.title = "Characters"
                    vc.tabBarItem.image = UIImage(systemName: "person.fill")
                } else if vc == controllers.last {
                    vc.tabBarItem.title = "Episodes"
                    vc.tabBarItem.image = UIImage(systemName: "video.fill")
                }
            }
        }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
    
}

