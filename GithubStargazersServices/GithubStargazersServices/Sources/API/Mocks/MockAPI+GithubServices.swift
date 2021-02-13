//
//  MockAPI+GithubServices.swift
//  GithubStargazersServices
//
//  Created by Claudio Barbera on 12/02/21.
//

import Foundation
import GithubStargazersModels

extension MockAPIServices: GithubServices {
   
    public func getStargazers(from request: StargazersRequestDTO, completion: @escaping ([GithubUser]?, Error?) -> Void) {
       
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            let mock = JSONMapOperation<[GithubUser]>()
            let users = mock.decode(from: "stargazers")
            completion(users, nil)
        }
    }
    
}
