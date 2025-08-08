//
//  Article.swift
//  autodoc
//
//  Created by Kirill Faifer on 08.08.2025.
//

import Foundation

struct Article: Decodable {
    
    let id: Int
    let title: String
    let description: String
    let publishedDate: Date
    let url: String
    let fullUrl: String
    let titleImageUrl: String
    let categoryType: String
    
}
