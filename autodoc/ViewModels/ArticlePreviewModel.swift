//
//  ArticlePreviewModel.swift
//  autodoc
//
//  Created by Kirill Faifer on 13.08.2025.
//

import Foundation

struct ArticlePreviewModel: Hashable {
    
    let uuid = UUID()
    let title: String
    let subtitle: String
    let imageURL: URL?
    let date: String
    let category: Article.Category
    
}
