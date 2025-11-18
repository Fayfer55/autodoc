//
//  NewsService.swift
//  autodoc
//
//  Created by Kirill Faifer on 11.08.2025.
//

import Foundation

struct NewsService: NewsServiceInterface {
    
    private let networkService = NetworkManager.shared
    
    // MARK: - NewsServiceInterface
    
    func news(page: Int, articlesPerPage: Int) async throws -> News {
        guard let url = URL(string: "https://webapi.autodoc.ru/api/news/\(page)/\(articlesPerPage)") else {
            throw URLError(.badURL)
        }
        return try await networkService.request(for: url)
    }
    
}
