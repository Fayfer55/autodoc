//
//  ArticlesCollectionDataSource.swift
//  autodoc
//
//  Created by Kirill Faifer on 13.08.2025.
//

import Foundation

enum ArticlesCollectionSection {
    case news
}

enum ArticlesCollectionRow: Hashable {
    case preview(ArticlePreviewModel)
}
