//
//  ReuseIdentifiable.swift
//  autodoc
//
//  Created by Kirill Faifer on 11.08.2025.
//

import Foundation

protocol ReuseIdentifiable {
    static var reuseId: String { get }
}

extension ReuseIdentifiable {
    
    static var reuseId: String { String(describing: self) }
    
}
