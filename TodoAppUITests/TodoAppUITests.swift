//
//  TodoAppUITests.swift
//  TodoAppUITests
//
//  Created by Felix Lunzenfichter on 11.11.20.
//

import XCTest

class TodoAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["plus"].tap()
        
        let keyPos15Key = app/*@START_MENU_TOKEN@*/.keys["key_pos_1_5"]/*[[".otherElements[\"gkb_input_view_controller_base\"]",".otherElements[\"gkb_keyboard_body\"]",".otherElements[\"gkb_keyboard_view_helper_body_view\"]",".keys[\"T\"]",".keys[\"key_pos_1_5\"]"],[[[-1,4],[-1,3],[-1,2,3],[-1,1,2],[-1,0,1]],[[-1,4],[-1,3],[-1,2,3],[-1,1,2]],[[-1,4],[-1,3],[-1,2,3]],[[-1,4],[-1,3]]],[0]]@END_MENU_TOKEN@*/
        keyPos15Key.tap()
        
        let keyPos13Key = app/*@START_MENU_TOKEN@*/.keys["key_pos_1_3"]/*[[".otherElements[\"gkb_input_view_controller_base\"]",".otherElements[\"gkb_keyboard_body\"]",".otherElements[\"gkb_keyboard_view_helper_body_view\"]",".keys[\"e\"]",".keys[\"key_pos_1_3\"]"],[[[-1,4],[-1,3],[-1,2,3],[-1,1,2],[-1,0,1]],[[-1,4],[-1,3],[-1,2,3],[-1,1,2]],[[-1,4],[-1,3],[-1,2,3]],[[-1,4],[-1,3]]],[0]]@END_MENU_TOKEN@*/
        keyPos13Key.tap()
        
        let keyPos22Key = app/*@START_MENU_TOKEN@*/.keys["key_pos_2_2"]/*[[".otherElements[\"gkb_input_view_controller_base\"]",".otherElements[\"gkb_keyboard_body\"]",".otherElements[\"gkb_keyboard_view_helper_body_view\"]",".keys[\"s\"]",".keys[\"key_pos_2_2\"]"],[[[-1,4],[-1,3],[-1,2,3],[-1,1,2],[-1,0,1]],[[-1,4],[-1,3],[-1,2,3],[-1,1,2]],[[-1,4],[-1,3],[-1,2,3]],[[-1,4],[-1,3]]],[0]]@END_MENU_TOKEN@*/
        keyPos22Key.tap()
        
        let keyPos15Key2 = app/*@START_MENU_TOKEN@*/.keys["key_pos_1_5"]/*[[".otherElements[\"gkb_input_view_controller_base\"]",".otherElements[\"gkb_keyboard_body\"]",".otherElements[\"gkb_keyboard_view_helper_body_view\"]",".keys[\"t\"]",".keys[\"key_pos_1_5\"]"],[[[-1,4],[-1,3],[-1,2,3],[-1,1,2],[-1,0,1]],[[-1,4],[-1,3],[-1,2,3],[-1,1,2]],[[-1,4],[-1,3],[-1,2,3]],[[-1,4],[-1,3]]],[0]]@END_MENU_TOKEN@*/
        keyPos15Key2.tap()

        app.buttons["Add New Todo"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.cells["circle, Test"].images["circle"].tap()
        tablesQuery.cells["circle.fill, Test"].images["circle.fill"].tap()
  
        tablesQuery.cells["circle, Test"].swipeLeft()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells[\"circle, Test\"].buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
