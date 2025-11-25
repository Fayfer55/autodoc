//
//  NewsFactory.swift
//  autodoc
//
//  Created by Kirill Faifer on 25.11.2025.
//

import UIKit.UIViewController

@MainActor
struct NewsFactory {
    
    private enum Constants {
        static let phoneArticlesPerPage = 15
        static let padArticlesPerPage = 30
    }
    
    // MARK: - Helpers
    
    static func makeNewsModule(device: UIUserInterfaceIdiom) -> UIViewController {
        let newsService = NewsService()
        let newsViewModel = NewsViewModel(
            newsService: newsService,
            articlesPerPage: device == .phone ? Constants.phoneArticlesPerPage : Constants.padArticlesPerPage
        )
        
        let imageManager = ImageManager.shared
        let articlesViewModel = ArticlesCollectionViewModel(imageManager: imageManager)
        let layoutProvider = ArticlesCollectionLayoutManager()
        let articlesCollection = ArticlesCollectionViewController(
            newsProvider: newsViewModel,
            layoutProvider: layoutProvider,
            viewModel: articlesViewModel
        )
        
        return NewsViewController(
            viewModel: newsViewModel,
            articlesCollection: articlesCollection
        )
    }
    
}
