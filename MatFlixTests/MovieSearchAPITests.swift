//
//  MovieSearchAPITests.swift
//  MatFlixTests
//
//  Created by Matheus Tavares on 03/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import XCTest
@testable import MatFlix

class MovieSearchAPITests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    //MARK : Json parsing / HTTP Request Test
    func testUpcomingListFetchRequest() {
        //Will test wheter the received page number and the requested page number are the same, and if the results aren't empty
        //removed tests for empty array, as higher pages might be empty

        let searchTerms: [[String: Any]] = [[ "term": "avengers", "shouldBeEmpty": false], [ "term": "ewqeqwqeweqweqw", "shouldBeEmpty": true], [ "term": "up", "shouldBeEmpty": false], [ "term": "matrix", "shouldBeEmpty": false], [ "term": "qeweqweqwweq", "shouldBeEmpty": true]]

        for value in searchTerms {
            searchMovie(query: value["term"] as! String, page: 1, shouldBeEmpty: value["shouldBeEmpty"] as! Bool)
        }

    }

    func searchMovie(query: String, page: Int, shouldBeEmpty: Bool) {

        let requestExpectation = expectation(description: "Wait for async request")

        let params = MovieRequestData(query: query, page: page)

        MovieSearchService.sharedInstance.getList(params: params, view: nil) {
            (receivedData) in

            XCTAssertEqual(receivedData.status, 200, "Request Failed. Status code should be 200")

            guard let response = receivedData.movieResponse else {
                XCTFail("Response nil")
                requestExpectation.fulfill()
                return
            }

            // let index = 3 // failing case
            // XCTAssertEqual(response.page, index)

            XCTAssertEqual(response.page, page) //passing case

            guard let _ = response.results else {
                // if no results are given, the url either didn't load properly or there's some error
                XCTFail("Results nil")
                requestExpectation.fulfill()
                return
            }

// CONTAINING QUERY CASE REMOVED BECAUSE SOME MOVIES WERE JUST RELATED TO THE QUERY SEARCHED

//            for result in results {
//                if let overview = result.overview, let originalTitle = result.originalTitle, let title = result.title {
//
//                    let containsKeyword = (overview.range(of: query, options: .caseInsensitive) != nil) || (originalTitle.range(of: query, options: .caseInsensitive) != nil) || (title.range(of: query, options: .caseInsensitive) != nil)
//                    // need to insert the case of one of them being nil
//                    XCTAssertTrue(containsKeyword, title + " should contain keyword " + query)
//
//                }
//            }

            requestExpectation.fulfill()
        }

        waitForExpectations(timeout: 30) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }

    }

}
