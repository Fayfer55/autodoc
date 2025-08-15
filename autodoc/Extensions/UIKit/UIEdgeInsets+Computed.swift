//
//  UIEdgeInsets+Computed.swift
//  autodoc
//
//  Created by Kirill Faifer on 15.08.2025.
//

import UIKit

extension UIEdgeInsets {
    
    var vertical: CGFloat {
        self.bottom + self.top
    }
    
    var horizontal: CGFloat {
        self.left + self.right
    }
    
}
