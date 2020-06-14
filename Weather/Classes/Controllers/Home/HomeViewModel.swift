//
//  HomeViewModel.swift
//  Weather
//
//  Created by Muhammad Nadeem on 12/06/2020.
//  Copyright © 2020 Muhammad Nadeem. All rights reserved.
//

import Foundation
import CoreLocation

class HomeViewModel {
    
    // MARK: Data
    public var weathersList: [WeatherViewModel] = DataStore.shared.weathersList.map{WeatherViewModel(weather: $0)}
    var refreshData: Bool = false

    // MARK: Functions
    
    /**
     Get current weather by city name
     - parameter completionBlock: closure to return back the success or failure result
     - parameter success: the process finished successfully
     - parameter error: error back from server
     */
    func getWeatherBy(cityNames: String, completionBlock: @escaping (_ success: Bool, _ error: ServerError?) -> Void) {
        // get current weather by city name
        let names = cityNames.components(separatedBy: ",")
        for name in names {
            let cityName = name.trimmingCharacters(in: .whitespacesAndNewlines)
            ApiManager.shared.getCurrentWeatherBy(cityName: cityName) { (success, error, weather) in
                if success {
                    if let weatherObj = weather {
                        let weatherViewModel = WeatherViewModel(weather: weatherObj)
                        self.weathersList.append(weatherViewModel)
                        if self.refreshData {
                            self.refreshData = false
                            DataStore.shared.weathersList = []
                        }
                        DataStore.shared.weathersList.append(weatherObj)
                    }
                    completionBlock(true, nil)
                }else {
                    completionBlock(false, error)
                }
            }
        }

    }
}
