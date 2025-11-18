//
//  NewsServiceInterface.swift
//  autodoc
//
//  Created by Kirill Faifer on 11.08.2025.
//

import Foundation

protocol NewsServiceInterface {
    func news(page: Int, articlesPerPage: Int) async throws -> News
}
