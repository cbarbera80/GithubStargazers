//
//  Coordinator.swift
//  GithubStargazers
//
//  Created by Claudio Barbera on 12/02/21.
//

import Foundation

protocol Coordinator: class {
    func start()
    var coordinators: [Coordinator] { get set }
}
