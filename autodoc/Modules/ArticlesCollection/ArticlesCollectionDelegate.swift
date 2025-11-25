//
//  ArticlesCollectionDelegate.swift
//  autodoc
//
//  Created by Kirill Faifer on 25.11.2025.
//

import Foundation

@MainActor
protocol ArticlesCollectionDelegate: AnyObject {
    func articleDidSelect(for model: ArticlePreviewModel)
}
