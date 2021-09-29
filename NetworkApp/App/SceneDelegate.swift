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
        let flowLayout = UICollectionViewFlowLayout()
        let episodesVc = EpisodesViewController(collectionViewLayout: flowLayout)

        let tabBarVc = TabBarController()
        tabBarVc.setViewControllers([charactercVc, episodesVc], animated: false)
        navigation = UINavigationController(rootViewController: tabBarVc)
        navigation.navigationBar.prefersLargeTitles = true
        
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
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

