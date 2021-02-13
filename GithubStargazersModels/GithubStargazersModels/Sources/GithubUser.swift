//
//  GithubUser.swift
//  GithubStargazersModels
//
//  Created by Claudio Barbera on 12/02/21.
//

import Foundation

public struct GithubUser: Decodable, Equatable {
    public let login: String
    public let id: Int
    public let avatarUrl: String
    
    public init(id: Int, login: String, avatarUrl: String) {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
    }
}
