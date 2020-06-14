//
//  HomeViewController.swift
//  Weather
//
//  Created by Muhammad Nadeem on 12/06/2020.
//  Copyright © 2020 Muhammad Nadeem. All rights reserved.
//

import UIKit

class HomeViewController: AbstractController {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataView: NoDataView!
    
    // MARK: Data
    private var heightForCell: CGFloat = 100
    var homeViewModel = HomeViewModel()
    var isClearAll = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "homeView"
        homeViewModel.refreshData = true
    }
    
    override func customizeView() {
        super.customizeView()
        
        // set title
//        self.setNavBarTitle(title: , color: AppColors.black)
        self.navigationItem.title = "HOME_TITLE".localized
        
        tableView.tableFooterView = UIView()
        noDataView.delegate = self
        if DataStore.shared.weathersList.count > 0 {
            tableView.isHidden = false
            noDataView.isHidden = true
        }else {
            tableView.isHidden = true
            noDataView.isHidden = false
            self.noDataView.updateText(type: .weathersListNoData)
        }

        // add weather nav button
        addRightNavButtons()
        //add clear all button if weathers are available
        if homeViewModel.weathersList.count > 0 {
            addClearButton()
        }
    }
    
    // MARK: Functions
    /// Add button
    func addRightNavButtons() {
        // add weather nav button
        var addImage: UIImage?
        var foreCastImage: UIImage?
        if #available(iOS 13.0, *) {
            addImage = UIImage(systemName: "plus.circle")
            foreCastImage = UIImage(systemName: "thermometer")
        } else {
            // Fallback on earlier versions
            addImage = UIImage(named: "add")
            foreCastImage = UIImage(named: "forecast")
        }
        
        let _navAddButton = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(self.addButtonAction))

        let _navForecastButton = UIBarButtonItem(image: foreCastImage, style: .plain, target: self, action: #selector(self.forecastButtonAction))
        
        self.navigationItem.rightBarButtonItems = [_navAddButton, _navForecastButton]
    }
    
    /// add action
    @objc func addButtonAction() {
        Presenter.shared.showAlert(style: .cityNameInput, delegate: self)
    }

    /// add action
    @objc func forecastButtonAction() {
        Presenter.shared.showForecastViewController()
    }
    
    // MARK: Functions
    /// Add button
    func addClearButton() {
        // add weather nav button
        let item = UIBarButtonItem(title: "CLEAR_ALL".localized, style: .plain, target: self, action: #selector(self.clearButtonAction))
        item.tintColor = AppColors.red
        self.navigationItem.leftBarButtonItem = item
    }
    
    /// Remove clear button
    func removeClearButton() {
        self.navigationItem.leftBarButtonItem = nil
    }
    
    /// add action
    @objc func clearButtonAction() {
        isClearAll = true
        Presenter.shared.showAlert(style: .defaultAlert, delegate: self, title: "POPUP_CITY_CLEAR_ALL_TITLE".localized, message: "POPUP_CITY_CLEAR_ALL_MSG".localized, actionTitle: "CONFIRM".localized)
    }
    
    /// fetch weather from network
    func fetchWeathers(cityNames: String) {
        homeViewModel.getWeatherBy(cityNames: cityNames) { (success, error) in
            if success {
                //refresh view
                self.tableView.reloadData()
                self.noDataView.isHidden = true
                self.tableView.isHidden = false
                //add clear all button if weathers are available
                if self.homeViewModel.weathersList.count > 0 {
                    self.addClearButton()
                }
            }else {
                self.noDataView.updateText(type: .weathersListNoData)
                self.noDataView.isHidden = false
                self.tableView.isHidden = true
            }
        }
    }

}

// MARK: -
// MARK: TableView Delegates & Datasource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.weathersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Prices cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherViewTableViewCell", for: indexPath) as! WeatherViewTableViewCell
        let weather = homeViewModel.weathersList[indexPath.row]
        cell.populateWeatherCell(weatherViewModel: weather)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCell
    }
}

// MARK: CustomAlert Delegate
extension HomeViewController: CustomAlertViewDelegate {
    func customAlertSecondButtonAction() {
        if isClearAll {
            isClearAll = false
            removeClearButton()
            DataStore.shared.weathersList = []
            homeViewModel.weathersList = []
            self.tableView.reloadData()
            tableView.isHidden = true
            noDataView.isHidden = false
            self.noDataView.updateText(type: .weathersListNoData)
        }else {
            fetchWeathers(cityNames: Presenter.shared.cityNames)
        }
    }
}

// MARK: -
// MARK: No Data view Delegate
extension HomeViewController: NoDataViewDelegate {
    func actionClicked(_ noDataView: NoDataView) {
        // Connection error: Try again
       Presenter.shared.showAlert(style: .cityNameInput, delegate: self)

    }
}
