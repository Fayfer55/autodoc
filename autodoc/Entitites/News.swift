//
//  News.swift
//  autodoc
//
//  Created by Kirill Faifer on 08.08.2025.
//

import Foundation

struct News: Decodable {
    
    let news: [Article]
    let totalCount: Int
    
}
