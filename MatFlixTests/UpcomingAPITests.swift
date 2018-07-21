//
//  UpcomingAPITests.swift
//  MatFlixTests
//
//  Created by Matheus Tavares on 03/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import XCTest
@testable import MatFlix

class UpcomingAPITests: XCTestCase {

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

        for index in 1...5 {
            fetchUpcomingList(page: index)
        }

    }

    func fetchUpcomingList(page: Int) {

        let requestExpectation = expectation(description: "Wait for async request")

        let params = MovieRequestData(page: page)
        UpcomingListService.sharedInstance.getList(params: params) {
            (receivedData) in

            XCTAssertEqual(receivedData.status, 200, "Request Failed. Status code should be 200")

            guard let response = receivedData.movieResponse else {
                XCTFail("Response nil")
                requestExpectation.fulfill()
                return
            }

            // let index = page > 3 ? 1 : page // failing case
            // XCTAssertEqual(response.page, index)

            XCTAssertEqual(response.page, page) //passing case

            guard let _ = response.results else {
                // if no results are given, the url either didn't load properly or there's some error
                XCTFail("Results nil")
                requestExpectation.fulfill()
                return
            }

            requestExpectation.fulfill()
        }

        waitForExpectations(timeout: 300) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }

    }

}
