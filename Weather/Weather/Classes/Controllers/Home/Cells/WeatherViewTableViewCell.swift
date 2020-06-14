//
//  WeatherViewTableViewCell.swift
//  Weather
//
//  Created by Muhammad Nadeem on 13/06/2020.
//  Copyright © 2020 Muhammad Nadeem. All rights reserved.
//

import UIKit

class WeatherViewTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var weatherCellView: WeatherCellView!
    
    // MARK: Data
    var weathersList = [WeatherViewModel]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: Cell life cycle
    public func populateWeatherCell(weatherViewModel: WeatherViewModel) {
    
        weatherCellView.cityNameLabel.text = weatherViewModel.cityName
        weatherCellView.descLabel.text = weatherViewModel.weatherElementViewModel.weatherDescription
        weatherCellView.windLabel.text = "Wind: \(Int(weatherViewModel.windViewModel.speed)) km/h"
        weatherCellView.minTempLabel.text = "Min: \(Int(weatherViewModel.mainViewModel.tempMin))°C"
        weatherCellView.maxTempLabel.text = "Max: \(Int(weatherViewModel.mainViewModel.tempMax))°C"
        weatherCellView.tempLabel.text = "\(Int(weatherViewModel.mainViewModel.temp))°C"

    }

}
