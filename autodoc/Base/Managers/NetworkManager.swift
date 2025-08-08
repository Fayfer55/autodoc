//
//  NetworkManager.swift
//  autodoc
//
//  Created by Kirill Faifer on 08.08.2025.
//

import Foundation
import OSLog

actor NetworkManager {
    
    // MARK: - Properties
    
    private let decodeManager: DecodeManagerInterface
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "autodoc.app", category: "Network Manager")
    
    // MARK: - Init
    
    init(decodeManager: DecodeManagerInterface) {
        self.decodeManager = decodeManager
    }
    
    func request<T: Decodable>(for url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        
        logger.debug("request for URL: \(url.absoluteString)")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        try handle(response: response)
        return try decodeManager.decode(data: data)
    }
    
    // MARK: - Private Helpers
    
    private func handle(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            logger.error("Bad Server Response Error")
            throw URLError(.badServerResponse)
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            logger.error("Network Error – \(httpResponse.statusCode)")
            throw URLError(_nsError: .init(domain: "Network Error", code: httpResponse.statusCode))
        }
    }
    
}

