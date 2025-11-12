//
//  UIView+NSLayoutConstraints.swift
//  autodoc
//
//  Created by Kirill Faifer on 12.11.2025.
//

import UIKit.UIView

extension UIView {
    
    func activate(constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
}
