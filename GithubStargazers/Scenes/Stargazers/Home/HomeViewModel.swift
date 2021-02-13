//
//  HomeViewModel.swift
//  GithubStargazers
//
//  Created by Claudio Barbera on 12/02/21.
//  Copyright (c) 2021. All rights reserved.
//

import GithubStargazersServices
import GithubStargazersModels
import RxSwift
import RxCocoa

class HomeViewModel {

    // MARK: - Business properties
    private let services: GithubServices
    var stargazersRelay = BehaviorRelay<[GithubUser]?>(value: nil)
    var userRelay = BehaviorRelay<String?>(value: nil)
    var repoRelay = BehaviorRelay<String?>(value: nil)
    var statusRelay = BehaviorRelay<HomeViewStatus>(value: .idle)
    
    private var isUserValid: Observable<Bool> {
        return userRelay
            .compactMap { $0 }
            .asObservable()
            .map { !$0.isEmpty}
    }
    
    private var isRepoValid: Observable<Bool> {
        return repoRelay
            .compactMap { $0 }
            .asObservable()
            .map { !$0.isEmpty}
    }
    
    var confirmButtonEnabled: Observable<Bool> {
        return Observable.combineLatest(isUserValid, isRepoValid) {
            $0 && $1
        }
    }
    
    // MARK: - Init
    init(services: GithubServices) {
        self.services = services
    }
    
    func makeRequest() {
        
        guard let user = userRelay.value, let repo = repoRelay.value else { return }
        
        statusRelay.accept(.loading)
        
        services.getStargazers(from: .init(user: user, repository: repo)) { [weak self] users, error in
            if let users = users {
                self?.stargazersRelay.accept(users)
                self?.statusRelay.accept(.dataFound)
            } else {
                self?.statusRelay.accept(.error)
            }
        }
    }
}
