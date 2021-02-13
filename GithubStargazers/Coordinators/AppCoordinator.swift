//
//  AppCoordinator.swift
//  GithubStargazers
//
//  Created by Claudio Barbera on 12/02/21.
//

import UIKit
import GithubStargazersModels
import GithubStargazersServices

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let services: GithubServices
    var coordinators: [Coordinator] = []
    
    init(withWindow window: UIWindow, services: GithubServices) {
        self.window = window
        self.services = services
    }
    
    func start() {
        coordinators.removeAll { $0 is HomeCoordinator }
        
        let homeCoordinator = HomeCoordinator(window: window, services: services)
        homeCoordinator.start()
        coordinators.append(homeCoordinator)
    }
}
