//
//  GithubServices.swift
//  GithubStargazersServices
//
//  Created by Claudio Barbera on 12/02/21.
//

import Foundation
import Moya
import GithubStargazersModels

enum GithubMoyaNetworkServices {
    case getStargazers(request: StargazersRequestDTO)
}

extension GithubMoyaNetworkServices: TargetType {

    var baseURL: URL {
        return URL(string: "https://api.github.com/")!
    }
    
    var path: String {
        switch self {
        
        // AuthServices
        case .getStargazers(let request):
            return "repos/\(request.user)/\(request.repository)/stargazers"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getStargazers:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getStargazers(let request):
            return .requestParameters(parameters: ["page": request.page], encoding: URLEncoding.default)
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var headers: [String: String]? {
        return ["Accept": "application/vnd.github.v3+json"]
    }
}
