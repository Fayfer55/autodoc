//
//  UIFont+Static.swift
//  autodoc
//
//  Created by Kirill Faifer on 12.11.2025.
//

import UIKit.UIFont

extension UIFont {
    
    static func systemProRoundedFont(ofSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont: UIFont = .systemFont(ofSize: ofSize, weight: weight)
        guard let descriptor = systemFont.fontDescriptor.withDesign(.rounded) else {
            return systemFont
        }
        return UIFont(descriptor: descriptor, size: ofSize)
    }
    
}
