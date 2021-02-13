//
//  API+GithubServices.swift
//  GithubStargazersServices
//
//  Created by Claudio Barbera on 12/02/21.
//

import Foundation
import GithubStargazersModels

extension APIServices: GithubServices {
    
    public func getStargazers(from request: StargazersRequestDTO, completion: @escaping ([GithubUser]?, Error?) -> Void) {
        
        provider.request(.getStargazers(request: request)) { results in
            
            switch results {
            case .success(let response):
                let users = try? response.map([GithubUser].self, using: APIServices.decoder)
                completion(users, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
