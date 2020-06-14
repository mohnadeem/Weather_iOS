//
//  ForecastViewTableViewCell.swift
//  Weather
//
//  Created by Muhammad Nadeem on 14/06/2020.
//  Copyright © 2020 Muhammad Nadeem. All rights reserved.
//

import UIKit

class ForecastViewTableViewCell : UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var weatherForecastList: [WeatherViewModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Cell life cycle
    func populateForecastCell(weatherForecastList: [WeatherViewModel], indexPath: IndexPath) {
        self.weatherForecastList = weatherForecastList
        collectionView.reloadData()

        if (weatherForecastList.count > 0) {
            label.text = DateHelper.string(withFormat: "dd MMMM YYYY", milliseconds: weatherForecastList[0].dateInt)
        }
    }
    
  
    // MARK: UICollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCollectionViewCell", for: indexPath) as! HourlyCollectionViewCell
        let weatherForecast = weatherForecastList[indexPath.row]
        cell.populateHourlyCell(forcastViewModel: weatherForecast)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherForecastList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 117, height: collectionView.bounds.height)
    }
    
}
