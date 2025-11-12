//
//  NewsServiceMock.swift
//  autodoc
//
//  Created by Kirill Faifer on 15.08.2025.
//

import Foundation

struct NewsServiceMock: NewsServiceInterface {
    
    func news(page: Int, articlePerPage: Int) async throws -> News {
        try await Task.sleep(for: .seconds(1))
        if articlePerPage > 0 {
            let articles = (0...articlePerPage - 1).map {
                Article(
                    id: $0,
                    title: "Title #\($0)",
                    description: "Some not long description",
                    publishedDate: .now,
                    url: "",
                    fullUrl: "",
                    titleImageUrl: nil,
                    category: Bool.random() ? .vehicle : .company
                )
            }
            return News(news: articles, totalCount: articles.count)
        } else {
            return News(news: [], totalCount: .zero)
        }
    }
    
}
