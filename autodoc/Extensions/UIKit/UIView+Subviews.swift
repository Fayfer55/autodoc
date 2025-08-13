//
//  UIView+Subviews.swift
//  autodoc
//
//  Created by Kirill Faifer on 12.08.2025.
//

import UIKit.UIView

extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            addSubview(subview)
        }
    }
    
    func addSubviews(_ subviews: [UIView]) {
        for subview in subviews {
            addSubview(subview)
        }
    }
    
}
