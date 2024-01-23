//
//  BambuserTestTests.swift
//  MoviePresenterTests
//
//  Created by test on 21/01/2024.
//

import XCTest
@testable import BambuserTest

// TODO: Add filter movies tests
final class MoviePresenterTests: XCTestCase {

    var presenter: MoviePresenter?
    
    var message: String?
    
    var expectation: XCTestExpectation?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.presenter = MoviePresenter(apiService: MockMovieService())
        self.presenter?.delegate = self
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.presenter = nil
    }

    func testLoadFirstPage() throws {
        self.expectation = expectation(description: "Load First Page")
        self.presenter?.getPopularMovies()
        waitForExpectations(timeout: 1)
                
        XCTAssertNil(self.message)
        XCTAssertEqual(self.presenter?.page, 1)
        XCTAssertEqual(self.presenter?.movies.count, 1)
    }
    
    func testLoadTwoPages() throws {
        self.expectation = expectation(description: "Load Two Page")
        self.presenter?.getPopularMovies()
        waitForExpectations(timeout: 1)
        
        self.expectation = expectation(description: "Load Two Page")
        self.presenter?.getPopularMovies()
        waitForExpectations(timeout: 1)
                
        XCTAssertNil(self.message)
        XCTAssertEqual(self.presenter?.page, 2)
        XCTAssertEqual(self.presenter?.movies.count, 2)
    }
    
    func testLoadThreePages() throws {
        self.expectation = expectation(description: "Load Three Pages")
        self.presenter?.getPopularMovies()
        waitForExpectations(timeout: 1)
        
        self.expectation = expectation(description: "Load Three Pages")
        self.presenter?.getPopularMovies()
        waitForExpectations(timeout: 1)
        
        self.expectation = expectation(description: "Load Three Pages")
        self.presenter?.getPopularMovies()
        waitForExpectations(timeout: 1)
                
        XCTAssertNil(self.message)
        XCTAssertEqual(self.presenter?.page, 3)
        XCTAssertEqual(self.presenter?.movies.count, 3)
    }
    
    func testLoadLastPage() throws {
        self.expectation = expectation(description: "Load Last Page")
        self.presenter?.getPopularMovies()
        waitForExpectations(timeout: 1)
        
        self.expectation = expectation(description: "Load Last Page")
        self.presenter?.getPopularMovies()
        waitForExpectations(timeout: 1)
        
        self.expectation = expectation(description: "Load Last Page")
        self.presenter?.getPopularMovies()
        waitForExpectations(timeout: 1)
        
        self.expectation = expectation(description: "Load Last Page")
        self.presenter?.getPopularMovies()
        waitForExpectations(timeout: 1)
                
        XCTAssertNotNil(self.message)
    }

}

extension MoviePresenterTests: MoviePresenterDelegate {
    
    func didGetPopularMovies(message: String?) {
        self.message = message
        self.expectation?.fulfill()
        self.expectation = nil
    }
    
    func didFilterMovies(text: String) {
        print("Do Nothing at this moment")
    }
    
}
