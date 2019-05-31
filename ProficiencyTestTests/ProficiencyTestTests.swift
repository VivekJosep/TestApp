//
//  ProficiencyTestTests.swift
//  ProficiencyTestTests
//
//  Created by mac_admin on 29/05/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import XCTest
@testable import ProficiencyTest

class ProficiencyTestTests: XCTestCase {
    let path = Bundle.main.path(forResource: "Facts", ofType: "json")
    let countryTitle: String = "About Canada"

    override func setUp() {
       super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testNetworkConnection() {
        
        if(Utility.isConnectedToInternet()) {
            let promise = expectation(description: "Completion Handler was successfully invoked")
            var responseError: Error?
            var responseData: Decodable?
            NetworkManager.getFacts {(facts,error) in
                if error != nil {
                    XCTAssert(false,"Failed to get data from server")
                }
                responseData = facts
                responseError = error
                promise.fulfill()
            }
            
            waitForExpectations(timeout: 10, handler: nil)
            XCTAssertNil(responseError)
            XCTAssertNotNil(responseData)
        } else {
            print("Internet connectoin required for the test")
        }
    }
    
    func testJSONParsing() {
        do {
            
            let fileContent = try String(contentsOfFile: path!, encoding: String.Encoding.ascii)
            
            let encodedString = fileContent.data(using: String.Encoding.utf8)! as Data
            let parsedData = try JSONDecoder().decode(CountryFacts.self, from: encodedString)
            
            XCTAssertNotNil(parsedData)
            XCTAssertEqual(parsedData.factList?.count, 14)
            XCTAssertEqual(parsedData.factsFiltered?.count, 13)
            XCTAssertEqual(parsedData.title, countryTitle)
            
           
        } catch let err {
            XCTFail("Parsing the data from stub faile with \(err.localizedDescription)")
        }
    }

}
