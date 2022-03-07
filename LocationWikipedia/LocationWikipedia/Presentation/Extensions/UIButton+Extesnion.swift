//
//  UIButton+Extesnion.swift
//  LocationWikipedia
//
//  Created by Mohammad Bitar on 3/7/22.
//

import Foundation
import UIKit

extension UIButton {
    
    var isValid: Bool {
        get { isEnabled }
        set {
            backgroundColor = newValue ? .clear : .lightText
            setTitleColor(.white, for: .normal)
            isEnabled = newValue
        }
    }
}
