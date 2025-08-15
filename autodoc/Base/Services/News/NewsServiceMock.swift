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
        return News(
            news: [Article(
                id: 0,
                title: "Some title",
                description: "Some description",
                publishedDate: .now,
                url: "google.com",
                fullUrl: "https://google.com",
                titleImageUrl: .mockCarURL,
                categoryType: "Auto category"
            )],
            totalCount: 1
        )
    }
    
}
