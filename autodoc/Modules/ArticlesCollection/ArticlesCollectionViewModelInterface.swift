//
//  ArticlesCollectionViewModelInterface.swift
//  autodoc
//
//  Created by Kirill Faifer on 14.08.2025.
//

import Foundation
import UIKit.UIImage
import Combine

typealias ArticlesCollectionViewModelInterface = ArticleCollectionImageFetchSubscriptionInterface & ArticlesCollectionImageFetchInterface

@MainActor
protocol ArticleCollectionImageFetchSubscriptionInterface {
    var imagePublisher: AnyPublisher<(UIImage?, IndexPath), Never> { get }
}

@MainActor
protocol ArticlesCollectionImageFetchInterface {
    func image(at indexPath: IndexPath, for url: URL)
    func cancelImageFetch(for url: URL)
}
