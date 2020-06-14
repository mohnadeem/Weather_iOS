//
//  HourlyCellView.swift
//  Weather
//
//  Created by Muhammad Nadeem on 14/06/2020.
//  Copyright © 2020 Muhammad Nadeem. All rights reserved.
//

import UIKit

class HourlyCellView : AbstractNibView {
    
    // MARK: Properties
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var weatherMainLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    
    
    // MARK: Data
    var forcastViewModel: WeatherViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.view.backgroundColor = AppColors.blueCustom
    }

    // MARK: Customise View
    override func customizeView() {
        super.customizeView()
        
        hourLabel.appStyle(text: "", font: AppFonts.xSmall, textColor: AppColors.white)
        weatherMainLabel.appStyle(text: "", font: AppFonts.bigBold, textColor: AppColors.white)
        temperatureLabel.appStyle(text: "", font: AppFonts.smallBold, textColor: AppColors.white)
        weatherDescriptionLabel.appStyle(text: "", font: AppFonts.xSmall, textColor: AppColors.white)
        minTemperatureLabel.appStyle(text: "", font: AppFonts.xSmall, textColor: AppColors.white)
        maxTemperatureLabel.appStyle(text: "", font: AppFonts.xSmall, textColor: AppColors.white)
    }
    
    func fillData(forcastViewModel: WeatherViewModel) {
        self.forcastViewModel = forcastViewModel
        hourLabel.text = DateHelper.string(withFormat: "h:mm a", milliseconds: forcastViewModel.dateInt)
        weatherMainLabel.text = forcastViewModel.weatherElementViewModel.mainDescription
        temperatureLabel.text = "\(Int(forcastViewModel.mainViewModel.temp))°C"
        weatherDescriptionLabel.text = forcastViewModel.weatherElementViewModel.weatherDescription
        minTemperatureLabel.text = "\(Int(forcastViewModel.mainViewModel.tempMin))°C"
        maxTemperatureLabel.text = "\(Int(forcastViewModel.mainViewModel.tempMax))°C"

    }
    
}
