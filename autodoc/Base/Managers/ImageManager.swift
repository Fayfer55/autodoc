//
//  ImageManager.swift
//  autodoc
//
//  Created by Kirill Faifer on 12.08.2025.
//

import Foundation
import UIKit.UIImage
import OSLog

actor ImageManager: ImageManagerInterface {
    
    // MARK: - Properties
    
    static let shared = ImageManager()
    
    private let cache: NSCache<NSString, UIImage> = NSCache()

    private let networkManager: NetworkManagerInterface
    private var tasks: [URL: Task<UIImage, Error>] = [:]
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "autodoc.app", category: "Image Manager")
    
    // MARK: - Init
    
    init(networkManager: NetworkManagerInterface) {
        self.networkManager = networkManager
    }
    
    private init() {
        networkManager = NetworkManager.shared
    }
    
    // MARK: - Helpers
    
    func image(for url: URL?) async throws -> UIImage {
        guard let url else { throw URLError(.badURL) }
        
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            logger.debug("loaded image from cache for \(url)")
            return image
        } else {
            if let existingTask = tasks[url] {
                logger.debug("awaiting existing task for \(url)")
                return try await existingTask.value
            } else {
                let task = Task {
                    try await fetchImage(from: url)
                }
                tasks[url] = task
                defer { tasks[url] = nil } // remove a task regardless of success or failure
                
                let image = try await task.value
                cache.setObject(image, forKey: url.absoluteString as NSString)
                guard !Task.isCancelled else { throw CancellationError() }
                return image
            }
        }
    }
    
    func cancelFetching(for url: URL) {
        guard let task = tasks[url] else { return }
        task.cancel()
        tasks[url] = nil
        logger.debug("task is cancelled for \(url)")
    }
    
    // MARK: - Private Helpers
    
    private func fetchImage(from url: URL) async throws -> UIImage {
        let data = try await networkManager.data(from: url)
        guard let image = UIImage(data: data) else { throw URLError(.cannotDecodeRawData) }
        return image
    }
    
}
