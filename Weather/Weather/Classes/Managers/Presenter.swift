//
//  Presenter.swift
//  Weather
//
//  Created by Muhammad Nadeem on 13/06/2020.
//  Copyright © 2020 Muhammad Nadeem. All rights reserved.
//

import Foundation
import UIKit

/**
 Repeated and generic actions to be excuted from any context of the app such as show alert
 */
class Presenter: NSObject {
    
    // MARK: Singelton
    public static var shared: Presenter = Presenter()
    public var cityNames: String = ""
    
    private override init(){
        super.init()
    }
        
    /// Show alert screen
    public func showAlert(style: CustomAlertStyle, delegate: CustomAlertViewDelegate?, title: String = "", message: String = "", actionTitle: String = "", alertImage: UIImage? = nil, completionBlock:(@escaping()->()) = {})   {
        let alertViewController = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "CustomAlertViewController") as! CustomAlertViewController
        alertViewController.setData(style: style, delegate: delegate, title: title, message: message, actionTitle: actionTitle, image: alertImage)
        
        alertViewController.modalPresentationStyle = .overFullScreen
        if let visibleController = UIApplication.visibleViewController() {
            if !visibleController.isBeingPresented {
                visibleController.present(alertViewController, animated: true, completion: {
                    completionBlock()
                })
            }
        }
    }
    
    /// Show winners
    public func showForecastViewController() {
        // open forecast page
        let forecastNavigationController = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "ForecastNavigationController")
//        forecastNavigationController.modalTransitionStyle = .flipHorizontal
//        forecastNavigationController.modalPresentationStyle = .fullScreen
        UIApplication.visibleViewController()?.present(forecastNavigationController, animated: true, completion: nil)
    }
}
