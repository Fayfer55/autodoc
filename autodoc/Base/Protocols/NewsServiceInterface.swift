//
//  NewsServiceInterface.swift
//  autodoc
//
//  Created by Kirill Faifer on 11.08.2025.
//

import Foundation

protocol NewsServiceInterface {
    func news(page: Int, articlePerPage: Int) async throws -> News
}
