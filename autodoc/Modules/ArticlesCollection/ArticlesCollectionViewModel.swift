//
//  ArticlesCollectionViewModel.swift
//  autodoc
//
//  Created by Kirill Faifer on 14.08.2025.
//

import Foundation
import Combine
import UIKit.UIImage

@MainActor
final class ArticlesCollectionViewModel: ArticlesCollectionViewModelInterface {
    
    // MARK: - ArticleCollectionImageFetchSubscriptionInterface
    
    var imagePublisher: AnyPublisher<(UIImage?, IndexPath), Never> {
        imageSubject.eraseToAnyPublisher()
    }
    
    private let imageSubject = PassthroughSubject<(UIImage?, IndexPath), Never>()
    
    // MARK: - DI
    
    private let imageManager: ImageManagerInterface
    
    // MARK: - Init
    
    init(imageManager: ImageManagerInterface) {
        self.imageManager = imageManager
    }
    
    // MARK: - ArticlesCollectionImageFetchInterface
    
    func image(at indexPath: IndexPath, for url: URL) {
        Task { [weak self] in
            guard let self else { return }
            do {
                let image = try await ImageManager.shared.image(for: url)
                guard !Task.isCancelled else { return }
                imageSubject.send((image, indexPath))
            } catch {
                imageSubject.send((nil, indexPath))
            }
        }
    }
    
    func cancelImageFetch(for url: URL) {
        Task {
            await ImageManager.shared.cancelFetching(for: url)
        }
    }
    
}
