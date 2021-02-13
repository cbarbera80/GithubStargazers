//
//  HomeCoordinator.swift
//  GithubStargazers
//
//  Created by Claudio Barbera on 12/02/21.
//  Copyright (c) 2021. All rights reserved.
//

import UIKit
import GithubStargazersServices
import GithubStargazersModels

class HomeCoordinator: Coordinator {

    // MARK: - Enums
    enum HomeStep {
        case home
        case results(users: [GithubUser], user: String, repo: String)
    }

    // MARK: - Architecture properties
    private let viewController: HomeViewController
    private let window: UIWindow
    private let navigator: UINavigationController
    private let services: GithubServices
    var coordinators: [Coordinator] = []
    
    // MARK: - init
    init(window: UIWindow, services: GithubServices) {
        self.services = services
        self.window = window
        viewController = HomeViewController(viewModel: .init(services: services))
        navigator = UINavigationController(rootViewController: viewController)
        
    }
    
    // MARK: - Coordinator
    func start() {
        viewController.delegate = self
        goTo(step: .home)
    }

    // MARK: - Private func
    private func goTo(step: HomeStep) {
        switch step {
        case .home:
            window.rootViewController = navigator
        case .results(let users, let user, let repo):
            let detailsVC = DetailsViewController(viewModel: .init(users: users, services: services, user: user, repo: repo))
            navigator.pushViewController(detailsVC, animated: true)
        }
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
  
    func showResults(_ results: [GithubUser], user: String, repo: String) {
        goTo(step: .results(users: results, user: user, repo: repo))
    }
}