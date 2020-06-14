//
//  ForecastViewController.swift
//  Weather
//
//  Created by Muhammad Nadeem on 13/06/2020.
//  Copyright © 2020 Muhammad Nadeem. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: AbstractController {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataView: NoDataView!
    
    // MARK: Data
    private let locationManager = CLLocationManager()
    private var heightForCell: CGFloat = 170
    var forecastViewModel = ForecastViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.accessibilityIdentifier = "forecastView"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CLLocationManager.authorizationStatus() == .denied {
            self.noDataView.updateText(type: .connection)
            self.noDataView.isHidden = false
            self.tableView.isHidden = true
        }else {
            self.noDataView.isHidden = true
            self.tableView.isHidden = false
        }
    }

    override func customizeView() {
        super.customizeView()

        // Show nav back button
        self.showNavCloseButton = true

        tableView.tableFooterView = UIView()
        tableView.isHidden = true
        noDataView.delegate = self
        noDataView.isHidden = true

        // My location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()

    }
    
    func fetchWeatherForecast(cityName: String) {
        forecastViewModel.getNextFiveWeatherForecastBy(cityName: cityName) { (success, error) in
            if success {
                //refresh view
                self.tableView.reloadData()
                self.noDataView.isHidden = true
                self.tableView.isHidden = false
                // set title
                self.setNavBarTitle(title: self.forecastViewModel.cityViewModel.name, color: AppColors.black)

            }else {
                self.noDataView.updateText(type: .weathersListNoResults)
                self.noDataView.isHidden = false
                self.tableView.isHidden = true
            }
        }
    }

    /// Fetch current location
        func fetchMyLocation() {
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways {
                if CLLocationManager.locationServicesEnabled()
                {
                    locationManager.startUpdatingLocation()
                    locationManager.requestLocation()
                }
            }
        }
        
        /// Show alert, if user denied location permission.
        private func showLocationPermission() {
            let alert = UIAlertController(title:"ERROR_LOCATION_PERMISSION".localized, message: "ERROR_LOCATION_PERMISSION_MSG".localized, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "CANCEL".localized, style: .cancel, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                default:
                    break
                }}))
            alert.addAction(UIAlertAction(title: "SETTINGS".localized, style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)")
                    })
                }
            })
            self.present(alert, animated: true, completion: nil)
        }
}

// MARK: -
// MARK: TableView Delegates & Datasource
extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastViewModel.weatherForecastList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Prices cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastViewTableViewCell", for: indexPath) as! ForecastViewTableViewCell
        let forcasts = forecastViewModel.weatherForecastList[indexPath.row]
        cell.populateForecastCell(weatherForecastList: forcasts, indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCell
    }
}

// MARK: -
// MARK: NoDataViewDelegate
extension ForecastViewController: NoDataViewDelegate {
    func actionClicked(_ noDataView: NoDataView) {
        if CLLocationManager.authorizationStatus() == .denied {
            showLocationPermission()
        }else {
            locationManager.startUpdatingLocation()
            locationManager.requestLocation()
        }
    }
}


// MARK: -
// MARK: CLLocationManagerDelegate
extension ForecastViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
     
                    // new address, get by coords.
        forecastViewModel.geocode(latitude: location.latitude, longitude: location.longitude) { placemark, error in
            guard let placemark = placemark, error == nil else { return }
            if let cityName = placemark.administrativeArea {
                self.fetchWeatherForecast(cityName: cityName)
            }
        }
        //stop updating location.
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            noDataView.isHidden = true
            tableView.isHidden = false
            fetchMyLocation()
            break
        case .notDetermined, .denied:
            tableView.isHidden = true
            noDataView.updateText(type: .weatherNoLocation)
            noDataView.isHidden = false
            break
        default:
            break
        }
    }
}
