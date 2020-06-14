//
//  WeatherCellView.swift
//  Weather
//
//  Created by Muhammad Nadeem on 13/06/2020.
//  Copyright © 2020 Muhammad Nadeem. All rights reserved.
//

import UIKit

class WeatherCellView: AbstractNibView {

    // MARK: Properties
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!

    
    // MARK: Customise View
    override func customizeView() {
        super.customizeView()
        
        cityNameLabel.appStyle(text: "", font: AppFonts.bigBold, textColor: AppColors.blueCustom)
        tempLabel.appStyle(text: "", font: AppFonts.bigBold, textColor: AppColors.blueCustom)
        descLabel.appStyle(text: "", font: AppFonts.small, textColor: AppColors.blueCustom)
        windLabel.appStyle(text: "", font: AppFonts.small, textColor: AppColors.blueCustom)
        minTempLabel.appStyle(text: "", font: AppFonts.small, textColor: AppColors.blueCustom)
        maxTempLabel.appStyle(text: "", font: AppFonts.small, textColor: AppColors.blueCustom)

    }

}
