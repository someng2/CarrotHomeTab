//
//  UIBarButtonItem+CustomView.swift
//  CarrotHomeTab
//
//  Created by 백소망 on 2022/09/23.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    static func generate(with config: CustomBarItemConfiguration, width: CGFloat? = nil) -> UIBarButtonItem {
        let customView = CustomBarItem(config: config)
        
        if let width = width {
            // autolayout
            NSLayoutConstraint.activate([
                customView.widthAnchor.constraint(equalToConstant: width)
            ])
        }
        
        let barButtonItem = UIBarButtonItem(customView: customView)
        return barButtonItem
        
    }
}
