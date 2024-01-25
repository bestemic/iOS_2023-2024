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
    }
    
    func testDisplayingDay() throws {
        XCTAssertTrue(app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["ENTER DAY OF WEEK"]/*[[".cells.staticTexts[\"ENTER DAY OF WEEK\"]",".staticTexts[\"ENTER DAY OF WEEK\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        
        let enterDayTextField = app.collectionViews/*@START_MENU_TOKEN@*/.textFields["Enter day"]/*[[".cells.textFields[\"Enter day\"]",".textFields[\"Enter day\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        enterDayTextField.tap()
        enterDayTextField.typeText("Monday")
        XCTAssertEqual(enterDayTextField.value as! String, "Monday")
        
        let submitButton = app.buttons["Submit"]
        submitButton.tap()
        
        let leftButton = app.buttons["Left"]
        let rightButton = app.buttons["Right"]
        
        XCTAssertTrue(leftButton.exists)
        XCTAssertTrue(rightButton.exists)
        
        XCTAssertFalse(leftButton.isEnabled)
        XCTAssertTrue(rightButton.isEnabled)
        
        XCTAssertEqual(enterDayTextField.value as! String, "Enter day")
        XCTAssertTrue(app.staticTexts["Monday"].exists)
        
        enterDayTextField.typeText("Saturday")
        XCTAssertEqual(enterDayTextField.value as! String, "Saturday")
        
        submitButton.tap()
        XCTAssertEqual(enterDayTextField.value as! String, "Enter day")
        XCTAssertTrue(app.staticTexts["Saturday"].exists)
        
        XCTAssertTrue(leftButton.isEnabled)
        XCTAssertTrue(rightButton.isEnabled)
        
        enterDayTextField.typeText("Sunday")
        XCTAssertEqual(enterDayTextField.value as! String, "Sunday")
        
        submitButton.tap()
        XCTAssertEqual(enterDayTextField.value as! String, "Enter day")
        XCTAssertTrue(app.staticTexts["Sunday"].exists)
        
        XCTAssertTrue(leftButton.isEnabled)
        XCTAssertFalse(rightButton.isEnabled)
    }
    
    func testChangingDays() throws {
        let enterDayTextField = app.collectionViews/*@START_MENU_TOKEN@*/.textFields["Enter day"]/*[[".cells.textFields[\"Enter day\"]",".textFields[\"Enter day\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        enterDayTextField.tap()
        enterDayTextField.typeText("Wednesday")
        app.buttons["Submit"].tap()
        
        let leftButton = app.buttons["Left"]
        let rightButton = app.buttons["Right"]
        
        XCTAssert(app.staticTexts["Wednesday"].exists)
        rightButton.tap()
        XCTAssert(app.staticTexts["Thursday"].exists)
        leftButton.tap()
        leftButton.tap()
        XCTAssert(app.staticTexts["Tuesday"].exists)
    }
}
