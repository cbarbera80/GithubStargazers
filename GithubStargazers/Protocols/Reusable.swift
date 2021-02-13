//
//  Reusable.swift
//  GithubStargazers
//
//  Created by Claudio Barbera on 12/02/21.
//

import UIKit

protocol ReusableSupplementaryView: class {
    static var kind: String { get }
}

extension ReusableSupplementaryView where Self: UIView {
    static var kind: String {
        return "kind_\(String(describing: self))"
    }
}

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
