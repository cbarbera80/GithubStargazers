//
//  DetailViewModelTest.swift
//  GithubStargazersTests
//
//  Created by Claudio Barbera on 12/02/21.
//

@testable import GithubStargazers
import XCTest
import RxSwift
import RxTest
import GithubStargazersServices
import GithubStargazersModels

class DetailViewModelTest: XCTestCase {
    
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        super.tearDown()
        scheduler = nil
        disposeBag = nil
    }
    
    func test_viewModel_shouldHaveInitialData() {
        
        let sut = getSUT()
        XCTAssertFalse(sut.stargazersRelay.value.isEmpty)
    }
    
    func test_viewModel_shouldStartWithPage1() {
        
        let sut = getSUT()
        XCTAssertEqual(sut.currentPage, 1)
    }
    
    func test_viewModel_searchShouldIncrementPage() {
        
        let sut = getSUT()
        
        sut.makeRequest()
        
        XCTAssertEqual(sut.currentPage, 2)
    }
    
    private func getSUT() -> DetailsViewModel {
        return DetailsViewModel(users: [GithubUser(id: 1, login: "user1", avatarUrl: "avatarurl")], services: MockAPIServices(), user: "user", repo: "repo")
    }
}
