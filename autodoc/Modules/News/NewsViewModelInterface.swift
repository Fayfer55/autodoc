//
//  NewsViewModelInterface.swift
//  autodoc
//
//  Created by Kirill Faifer on 08.08.2025.
//

import Foundation
import Combine

typealias NewsViewModelInterface = NewsFetchInterface & NewsSubscribeInterface

protocol NewsFetchInterface {
    @MainActor
    var nextPageNeeded: Bool { get }
    
    func fetch() async throws
    func nextPage() async throws
}

@MainActor
protocol NewsSubscribeInterface: AnyObject {
    var articlesPublisher: AnyPublisher<[Article], Never> { get }
}
