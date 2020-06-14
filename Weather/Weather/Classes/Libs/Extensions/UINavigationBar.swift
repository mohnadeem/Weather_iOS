//
//  UINavigationBar.swift
//  Weather
//
//  Created by Muhammad Nadeem on 12/06/2020.
//  Copyright © 2020 Muhammad Nadeem. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    static let navBorderTag: Int = -999
    
    /// Set navigation bar bottom border
    func setBottomBorderColor(color: UIColor) {
        let lineFrame = CGRect(x: 0, y: frame.size.height - 0.5, width: frame.size.width, height: 0.5)
        let navigationSeparator = UIView(frame: lineFrame)
        navigationSeparator.backgroundColor = color
        navigationSeparator.isOpaque = true
        navigationSeparator.tag = UINavigationBar.navBorderTag
        while let oldView = self.viewWithTag(UINavigationBar.navBorderTag) {
            oldView.removeFromSuperview()
        }
        self.addSubview(navigationSeparator)
    }
}
