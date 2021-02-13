//
//  SceneDelegate.swift
//  GithubStargazers
//
//  Created by Claudio Barbera on 12/02/21.
//

import UIKit
import GithubStargazersServices

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let windowScene = scene as? UIWindowScene else { return }
    
        let appWindow = UIWindow(windowScene: windowScene)
       
        let appCoordinator = AppCoordinator(withWindow: appWindow, services: APIServices())
       
        appCoordinator.start()
        
        coordinator = appCoordinator
        window = appWindow
        
        window?.makeKeyAndVisible()
    }
}
