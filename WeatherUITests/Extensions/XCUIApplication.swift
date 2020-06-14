//
//  XCUIApplication.swift
//  WeatherUITests
//
//  Created by Muhammad Nadeem on 14/06/2020.
//  Copyright © 2020 Muhammad Nadeem. All rights reserved.
//

import XCTest

extension XCUIApplication {
    
    /// Is displaying home
    var isDisplayingHome: Bool {
        return otherElements["homeView"].exists
    }
    
    /// Check if app is running
    var isRunning: Bool {
        if self.state == .runningForeground {
            return true
        }
        return false
    }
}
