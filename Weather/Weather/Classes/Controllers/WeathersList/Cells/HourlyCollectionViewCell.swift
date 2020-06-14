//
//  HourlyCollectionViewCell.swift
//  Weather
//
//  Created by Muhammad Nadeem on 14/06/2020.
//  Copyright © 2020 Muhammad Nadeem. All rights reserved.
//

import Foundation
import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {

    // MARK: Properties
    @IBOutlet weak var hourlyCellView: HourlyCellView!

    override func awakeFromNib() {
        super.awakeFromNib()
        hourlyCellView.cornerRadius = 15
    }
    
    // MARK: Cell life cycle
    public func populateHourlyCell(forcastViewModel: WeatherViewModel) {
        hourlyCellView.fillData(forcastViewModel: forcastViewModel)
    }

}
