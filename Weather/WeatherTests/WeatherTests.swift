//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Muhammad Nadeem on 12/06/2020.
//  Copyright © 2020 Muhammad Nadeem. All rights reserved.
//

import Foundation
import XCTest
@testable import Weather

class WeatherTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /// Test Weather Model and View Model
    func testWeatherModel() {
        
        let weatherElement = WeatherElement(id: "1", weatherDescription: "clear sky", mainDescription: "Clear")
        let main = Main(id: "1", temp: 38.25, tempMin: 3.87, tempMax: 38.25)
        
        let wind = Wind(id: "1", speed: 4.8)
        
        let weather = Weather(id: "1", cityName: "Abu Dhabi", dateInt: 1592071200, weatherElement: weatherElement, main: main, wind: wind)
                
        let weatherViewModel = WeatherViewModel(weather: weather)

        XCTAssertEqual(weather.cityName, weatherViewModel.cityName)
        XCTAssertEqual(weather.dateInt, weatherViewModel.dateInt)
        XCTAssertEqual(weather.weatherElement?.weatherDescription, weatherViewModel.weatherElementViewModel.weatherDescription)
        XCTAssertEqual(weather.weatherElement?.mainDescription, weatherViewModel.weatherElementViewModel.mainDescription)

        XCTAssertEqual(weather.main?.temp, weatherViewModel.mainViewModel.temp)
        XCTAssertEqual(weather.main?.tempMin, weatherViewModel.mainViewModel.tempMin)
        XCTAssertEqual(weather.main?.tempMax, weatherViewModel.mainViewModel.tempMax)
        XCTAssertEqual(weather.wind?.speed, weatherViewModel.windViewModel.speed)

    }
    
}
