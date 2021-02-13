//
//  GithubStargazersUITests.swift
//  GithubStargazersUITests
//
//  Created by Claudio Barbera on 12/02/21.
//

import XCTest
@testable import GithubStargazers

class HomeViewUITest: XCTestCase {

    var sut: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        sut = XCUIApplication()
        sut.launch()
    }
    
    func test_searchButton_shouldDisabledWhenStart() {
       
        let searchButton = sut.buttons[HomeViewAccessibilityIdentifiers.searchButtonIdentifier.rawValue]
        
        XCTAssertTrue(searchButton.waitForExistence(timeout: 1.0))
        XCTAssert(!searchButton.isEnabled)
    }
    
    func test_searchButton_shouldDisabledWithoutRepo() {
        
        let searchButton = sut.buttons[HomeViewAccessibilityIdentifiers.searchButtonIdentifier.rawValue]
        let userTextField = sut.textFields[HomeViewAccessibilityIdentifiers.userTextFieldIdentifier.rawValue]
        
        userTextField.tap()
        userTextField.typeText("user")
        
        XCTAssertTrue(userTextField.waitForExistence(timeout: 1.0))
        XCTAssert(!searchButton.isEnabled)
    }
    
    func test_searchButton_shouldDisabledWithoutUser() {
       
        let searchButton = sut.buttons[HomeViewAccessibilityIdentifiers.searchButtonIdentifier.rawValue]
        let repoTextField = sut.textFields[HomeViewAccessibilityIdentifiers.repoTextFieldIdentifier.rawValue]
        
        repoTextField.tap()
        repoTextField.typeText("repo")
        
        XCTAssertTrue(repoTextField.waitForExistence(timeout: 1.0))
        XCTAssert(!searchButton.isEnabled)
    }
    
    func test_searchButton_shouldEnabledWithData() {
       
        let searchButton = sut.buttons[HomeViewAccessibilityIdentifiers.searchButtonIdentifier.rawValue]
        let repoTextField = sut.textFields[HomeViewAccessibilityIdentifiers.repoTextFieldIdentifier.rawValue]
        let userTextField = sut.textFields[HomeViewAccessibilityIdentifiers.userTextFieldIdentifier.rawValue]
        
        userTextField.tap()
        userTextField.typeText("user")
        
        repoTextField.tap()
        repoTextField.typeText("repo")
        
        XCTAssert(searchButton.isEnabled)
    }
}
