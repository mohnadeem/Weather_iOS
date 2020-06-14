//
//  ForecastViewModel.swift
//  Weather
//
//  Created by Muhammad Nadeem on 13/06/2020.
//  Copyright © 2020 Muhammad Nadeem. All rights reserved.
//

import Foundation
import CoreLocation

class ForecastViewModel {
    
    // MARK: Data
    public var weatherForecastList: [[WeatherViewModel]] = [[]]
    public var cityViewModel: CityViewModel = CityViewModel(city: City())
    
    // MARK: Functions
    
    /**
    This function is to group the samples by their date
    - parameter weatherForecastList: the list of forecasts
    - returns: grouped forecasts array
    */
    func groupedWeathers(weatherForecastList: [WeatherViewModel]) -> [[WeatherViewModel]] {
        
        if weatherForecastList.count < 1 {
            return [[]]
        }
        // Helper variable to map the weather by their date
        var dict: [String:[WeatherViewModel]] = [:]
        
        for wf in weatherForecastList {
            let dateKey = DateHelper.string(withFormat: "YYYYMMdd", milliseconds: wf.dateInt)
            if (dict[dateKey] == nil || dict[dateKey]!.count < 1) {
                dict[dateKey] = []
            }
            dict[dateKey]?.append(wf)
        }
        
        var retval: [[WeatherViewModel]] = []
        
        let sortedKeys = Array(dict.keys).sorted()
        for key in sortedKeys {
            retval.append(dict[key]!)
        }
        
        return retval
    }
    
    /**
     Get next five weather forecast by city name
     - parameter cityName: the name of city
     - parameter completionBlock: closure to return back the success or failure result
     - parameter success: the process finished successfully
     - parameter error: error back from server
     */
    func getNextFiveWeatherForecastBy(cityName: String, completionBlock: @escaping (_ success: Bool, _ error: ServerError?) -> Void) {
        // get next five weather forecast by city name
        ApiManager.shared.getNextFiveWeatherForecastBy(cityName: cityName) { (success, error, forecastList, city)  in
            if success {
                if let forecastArr = forecastList {
                    let weatherForecastList = forecastArr.map({return WeatherViewModel(weather: $0)})
                    self.weatherForecastList = self.groupedWeathers(weatherForecastList: weatherForecastList)
                    self.cityViewModel = CityViewModel(city: city ?? City())
                }
                completionBlock(true, nil)
            }else {
                completionBlock(false, error)
            }
        }
    }
    
    /// CLGeocoder for getting the city name through coordinates
    func geocode(latitude: Double, longitude: Double, completion: @escaping (CLPlacemark?, Error?) -> ())  {
        let local = Locale(identifier: "en_US")
        if #available(iOS 11.0, *) {
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude), preferredLocale: local) { completion($0?.first, $1) }
        } else {
            // Fallback on earlier versions
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { completion($0?.first, $1) }
        }
    }
}
