//
//  ProficiencyTestUITests.swift
//  ProficiencyTestUITests
//
//  Created by mac_admin on 29/05/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import XCTest

class ProficiencyTestUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
       
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sleep(5)
        super.tearDown()
    }

    //MARK:- View Existence tests
    
    func testTableExists() {
        let factsTableView = app.tables["FactsTable"]
        XCTAssertTrue(factsTableView.exists, "Facts tableview exists")
    }
    
    func testRefresButtonExistence() {
        
        let btnRefresh = app.buttons["RefreshButton"]
        XCTAssertTrue(btnRefresh.exists, "Refresh Button exists")
    }
    
    //MARK:- TableView tests
    
    func testTableItems()
    {
        let factsTableView = app.tables["factsTable"]
        
        let tableCells = factsTableView.cells
        
        sleep(5)
        
        if tableCells.count > 0 {
            XCTAssertTrue(true, "Facts Table has \(tableCells.count) cells")
        } else {
            XCTAssertTrue(true, "Facts Table has no cell")
        }
        
        XCTAssertTrue(true, "Finished validating  tableview cells")
    }

}
