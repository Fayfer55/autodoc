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
    
    func news(page: Int, articlePerPage: Int) async throws -> News {
        guard let url = URL(string: "https://webapi.autodoc.ru/api/news/\(page)/\(articlePerPage)") else {
            throw URLError(.badURL)
        }
        return try await networkService.request(for: url)
    }
    
}
