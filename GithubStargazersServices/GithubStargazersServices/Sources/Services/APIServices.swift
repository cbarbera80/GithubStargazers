//
//  APIServices.swift
//  GithubStargazersServices
//
//  Created by Claudio Barbera on 12/02/21.
//

import Foundation
import Moya
import Result

public class APIServices {
    
    let provider: MoyaProvider<GithubMoyaNetworkServices>
    
    static var decoder: JSONDecoder {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    public init() {
        provider = MoyaProvider<GithubMoyaNetworkServices>(plugins: [NetworkLoggerPlugin(verbose: false, cURL: true)])
    }
}

public class MockAPIServices {
    public init() {}
    
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
