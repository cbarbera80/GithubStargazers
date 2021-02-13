//
//  GithubServices.swift
//  GithubStargazersServices
//
//  Created by Claudio Barbera on 12/02/21.
//

import Foundation
import GithubStargazersModels

public protocol GithubServices {
    
    func getStargazers(from request: StargazersRequestDTO, completion: @escaping ([GithubUser]?, Error?) -> Void)
}
