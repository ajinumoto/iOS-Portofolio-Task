//
//  SceneDelegate.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 30/03/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScane = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScane)
        window?.windowScene = windowScane
        window?.makeKeyAndVisible()
        
        let tab = UITabBarController()
        
        let qrisViewController = UINavigationController(rootViewController: QRISHomeRouter.createModule())
        let promoController = UINavigationController(rootViewController: HomePromoRouter.createModule())
        let portofolioController = UINavigationController(rootViewController: HomePortofolioRouter.createModule())
        
        qrisViewController.tabBarItem = UITabBarItem(title: "QRIS Payment", image: UIImage(systemName: "qrcode"),selectedImage: UIImage(systemName: "qrcode.fill"))
        promoController.tabBarItem = UITabBarItem(title: "Promo", image: UIImage(systemName: "giftcard"),selectedImage: UIImage(systemName: "giftcard.fill"))
        portofolioController.tabBarItem = UITabBarItem(title: "Portofolio", image: UIImage(systemName: "chart.pie"),selectedImage: UIImage(systemName: "chart.pie.fill"))
        
        tab.viewControllers = [qrisViewController, promoController, portofolioController]
        
        window?.rootViewController = tab
        
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

