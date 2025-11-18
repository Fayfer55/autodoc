//
//  NewsServiceMock.swift
//  autodoc
//
//  Created by Kirill Faifer on 15.08.2025.
//

import Foundation

struct NewsServiceMock: NewsServiceInterface {
    
    func news(page: Int, articlesPerPage: Int) async throws -> News {
        try await Task.sleep(for: .seconds(1))
        if articlesPerPage > 0 {
            let articles = (0...articlesPerPage - 1).map {
                Article(
                    id: (page - 1) * articlesPerPage + $0,
                    title: "Title #\((page - 1) * articlesPerPage + $0)",
                    description: "Some not long description",
                    publishedDate: .now,
                    url: "",
                    fullUrl: "",
                    titleImageUrl: Bool.random() ? .mockCarURL : nil,
                    category: Bool.random() ? .vehicle : .company
                )
            }
            return News(news: articles, totalCount: articles.count)
        } else {
            return News(news: [], totalCount: .zero)
        }
    }
    
}
