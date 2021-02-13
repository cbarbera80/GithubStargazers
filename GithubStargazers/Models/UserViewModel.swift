//
//  UserViewModel.swift
//  GithubStargazers
//
//  Created by Claudio Barbera on 12/02/21.
//

import Foundation
import GithubStargazersModels

struct UserViewModel {
    
    let user: GithubUser
    
    init(user: GithubUser) {
        self.user = user
    }
    
    var userText: String {
        return user.login
    }
    
    var userPictureURL: URL? {
        return URL(string: user.avatarUrl)
    }
}
