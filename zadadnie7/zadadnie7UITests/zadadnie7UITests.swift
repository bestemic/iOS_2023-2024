//
//  zadadnie7UITests.swift
//  zadadnie7UITests
//
//  Created by Przemek Pawlik on 20/01/2024.
//

import XCTest

final class zadadnie7UITests: XCTestCase {
    
    var app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testChangingTab() throws {
        let weekLabel = app.staticTexts["Week"]
        XCTAssertTrue(weekLabel.exists)
        
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssertTrue(tabBar.exists)
        
        let shopButton = tabBar.buttons["Shop"]
        XCTAssertTrue(shopButton.exists)
    
        shopButton.tap()
        let shopLabel = app.staticTexts["Shop View"]
        XCTAssertTrue(shopLabel.exists)
        
        let tabBarOnShop = app.tabBars["Tab Bar"]
        XCTAssertTrue(tabBarOnShop.exists)
        
        let weekButton = tabBarOnShop.buttons["Week"]
        XCTAssertTrue(weekButton.exists)
        weekButton.tap()
        
        XCTAssertTrue(app.staticTexts["Week"].exists)
        
        
        // 7 assercji
    }
    
    func testDisplayingError() throws {
        let submitButton = app.buttons["Submit"]
        XCTAssertTrue(submitButton.exists)
        submitButton.tap()
        
        let alert = app.alerts["Error"]
        XCTAssertTrue(alert.exists)
        
        let elementsQuery = alert.scrollViews.otherElements
        XCTAssertTrue(elementsQuery.staticTexts["Nothing provided"].exists)
        
        let okButton = elementsQuery.buttons["OK"]
        XCTAssertTrue(okButton.exists)
        okButton.tap()
        
        let input = app.collectionViews/*@START_MENU_TOKEN@*/.textFields["Enter day"]/*[[".cells.textFields[\"Enter day\"]",".textFields[\"Enter day\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(input.exists)
        
        input.tap()
        input.typeText("Test")
        XCTAssertEqual(input.value as! String, "Test")
                
        submitButton.tap()
        XCTAssertTrue(alert.exists)
        XCTAssertTrue(elementsQuery.staticTexts["Invalid day entered"].exists)
        okButton.tap()
        XCTAssertEqual(input.value as! String, "Enter day")
        
        // 9 assercji
    }
}
