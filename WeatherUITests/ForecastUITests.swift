//
//  ForecastUITests.swift
//  WeatherUITests
//
//  Created by Muhammad Nadeem on 14/06/2020.
//  Copyright © 2020 Muhammad Nadeem. All rights reserved.
//

import XCTest

class ForecastUITests: XCTestCase {
    var app = XCUIApplication()
    
    // MARK: Testing Life Cycle
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
     Test Prices page
     */
    func testForecastPage() {
        
        // Step1: launch app
        app = XCUIApplication()
        
        // Step2: go to home screen
        waitForHomeView(app)
        
        if app.isRunning {
            
            // Step3: open forecast page
            if #available(iOS 13.0, *) {
                app.navigationBars["Weather"].buttons["thermometer"].tap()
            }else {
                app.navigationBars["Weather"].buttons["forecast"].tap()
            }
        }
        sleep(8)
        // close forecast page
        app.navigationBars.matching(identifier: "Weather.ForecastView").buttons["navClose"].tap()
        sleep(2)
        if app.isDisplayingHome {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
}
