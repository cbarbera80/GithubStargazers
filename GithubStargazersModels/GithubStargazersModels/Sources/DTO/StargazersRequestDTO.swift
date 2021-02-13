//
//  StargazersRequestDTO.swift
//  GithubStargazersModels
//
//  Created by Claudio Barbera on 12/02/21.
//

import Foundation

public struct StargazersRequestDTO: Encodable {
    public let user: String
    public let repository: String
    public let page: Int
    
    public init(user: String, repository: String, page: Int = 0) {
        self.user = user
        self.repository = repository
        self.page = page
    }
}
