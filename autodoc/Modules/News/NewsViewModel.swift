//
//  NewsViewModel.swift
//  autodoc
//
//  Created by Kirill Faifer on 12.11.2025.
//

import Foundation
import Combine

@MainActor
final class NewsViewModel: NewsViewModelInterface {
    
    // MARK: - NewsSubscribeInterface
    
    var articlesPublisher: AnyPublisher<[Article], Never> {
        articlesSubject.eraseToAnyPublisher()
    }
    
    var nextPageNeeded: Bool {
        guard totalArticlesCount != .zero else { return false }
        return page * articlesPerPage < totalArticlesCount
    }
    
    // MARK: - Private Properties
    
    private let articlesSubject = PassthroughSubject<[Article], Never>()
    
    private let articlesPerPage: Int
    private var totalArticlesCount = 0
    private var page = 1
    
    // MARK: - DI
    
    nonisolated
    private let newsService: NewsServiceInterface
    
    // MARK: - Init
    
    init(newsService: NewsServiceInterface, articlesPerPage: Int) {
        self.newsService = newsService
        self.articlesPerPage = articlesPerPage
    }
    
    // MARK: - NewsFetchInterface
    
    func fetch() async throws {
        let object = try await newsService.news(page: page, articlesPerPage: articlesPerPage)
        
        totalArticlesCount = object.totalCount
        articlesSubject.send(object.news)
    }
    
    func nextPage() async throws {
        page += 1
        
        try await fetch()
    }
    
}
