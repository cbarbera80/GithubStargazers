//
//  JSONMapOperation.swift
//  GithubStargazersServices
//
//  Created by Claudio Barbera on 12/02/21.
//

import Foundation

final class JSONMapOperation<Model: Decodable> {
    
    func decode(from path: String, decoder: JSONDecoder = MockAPIServices.decoder) -> Model? {
        
        let bundle = Bundle(for: type(of: self))
        
        guard let jsonFile = bundle.path(forResource: path, ofType: "json") else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile), options: []) else {
            return nil
        }
        
        let model = try? decoder.decode(Model.self, from: data)
        return model
    }
}
