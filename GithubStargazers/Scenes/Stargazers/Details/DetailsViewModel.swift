//
//  DetailsViewModel.swift
//  GithubStargazers
//
//  Created by Claudio Barbera on 12/02/21.
//  Copyright (c) 2021. All rights reserved.
//

import GithubStargazersModels
import GithubStargazersServices
import RxSwift
import RxCocoa

class DetailsViewModel {

    // MARK: - Business properties
    private let services: GithubServices
    private let user: String
    private let repo: String
    var currentPage = 1
    
    let stargazersRelay: BehaviorRelay<[UserViewModel]>
    var statusRelay = BehaviorRelay<DetailsViewStatus>(value: .idle)
    
    var titleText: String {
        return "\(user) - \(repo)"
    }
    
    init(users: [GithubUser], services: GithubServices, user: String, repo: String) {
        self.services = services
        self.stargazersRelay = BehaviorRelay<[UserViewModel]>(value: users.map { UserViewModel(user: $0) })
        self.user = user
        self.repo = repo
    }
    
    func makeRequest() {
        currentPage += 1
        statusRelay.accept(.loading)
        
        services.getStargazers(from: .init(user: user, repository: repo, page: currentPage)) { [weak self] users, _ in
            
            self?.statusRelay.accept(.idle)
            
            if let users = users {
                var currentUsers = self?.stargazersRelay.value.map { $0.user } ?? []
                currentUsers += users
                self?.stargazersRelay.accept(currentUsers.map { UserViewModel(user: $0) })
            }
        }
    }
}
