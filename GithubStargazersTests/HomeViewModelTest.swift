//
//  GithubStargazersTests.swift
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

class HomeViewModelTest: XCTestCase {
    
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
    
    func test_searchButton_shouldEnabled_withAllData() {
        
        let sut = getSUT()
        
        let isSearchButtonEnabled = scheduler.createObserver(Bool.self)
        
        sut
            .confirmButtonEnabled
            .bind(to: isSearchButtonEnabled)
            .disposed(by: disposeBag)
        
        sut.userRelay.accept("user")
        sut.repoRelay.accept("repo")
        
        XCTAssertRecordedElements(isSearchButtonEnabled.events, [true])
    }
    
    func test_searchButton_shouldDisabled_withNoUser() {
        
        let sut = getSUT()
        
        let isSearchButtonEnabled = scheduler.createObserver(Bool.self)
        
        sut
            .confirmButtonEnabled
            .bind(to: isSearchButtonEnabled)
            .disposed(by: disposeBag)
        
        sut.repoRelay.accept("repo")
        sut.userRelay.accept("")
        
        XCTAssertRecordedElements(isSearchButtonEnabled.events, [false])
    }
    
    func test_searchButton_shouldDisabled_withNoRepo() {
        
        let sut = getSUT()
        
        let isSearchButtonEnabled = scheduler.createObserver(Bool.self)
        
        sut
            .confirmButtonEnabled
            .bind(to: isSearchButtonEnabled)
            .disposed(by: disposeBag)
        
        sut.repoRelay.accept("")
        sut.userRelay.accept("user")
        
        XCTAssertRecordedElements(isSearchButtonEnabled.events, [false])
    }
    
    func test_search_shouldProduceResults() {
        
        let sut = getSUT()
        
        let exp = expectation(description: "Search should return some data")
    
        sut
            .stargazersRelay
            .skip(1)
            .asObservable()
            .compactMap { $0 }
            .subscribe { data in
                XCTAssertNotNil(data)
                XCTAssert(data.element!.count != 0)
                exp.fulfill()
            }
        .disposed(by: disposeBag)
     
        sut.userRelay.accept("user")
        sut.repoRelay.accept("repo")
        
        sut.makeRequest()
        
        wait(for: [exp], timeout: 10)
    }
    
    func test_search_shouldChangeStatus() {
        
        let sut = getSUT()
        
        let exp = expectation(description: "Search should change home view status")
        
        sut
            .statusRelay
            .skip(2)
            .asObservable()
            .subscribe { data in
                XCTAssertEqual(data.element, .dataFound)
                exp.fulfill()
            }
        .disposed(by: disposeBag)
        
        sut.userRelay.accept("user")
        sut.repoRelay.accept("repo")
        
        sut.makeRequest()
        
        wait(for: [exp], timeout: 10)
    }
    
    private func getSUT() -> HomeViewModel {
        return HomeViewModel(services: MockAPIServices())
    }
}
