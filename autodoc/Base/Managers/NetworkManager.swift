//
//  NetworkManager.swift
//  autodoc
//
//  Created by Kirill Faifer on 08.08.2025.
//

import Foundation
import OSLog

/// I built a package for a network by myself. I started when the swift concurrency was just released and there was no Alamofire support for it yet. So i supported it while i was working at the previous job
/// https://git.ltst.su/ios-public/awaitnetworkservice
actor NetworkManager: NetworkManagerInterface {
    
    private enum Constants {
        static let timeoutInterval: TimeInterval = 10
    }
    
    // MARK: - Properties
    
    static let shared = NetworkManager()
    
    private let decodeManager: DecodeManagerInterface
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "autodoc.app", category: "Network Manager")
    
    // MARK: - Init
    
    init(decodeManager: DecodeManagerInterface) {
        self.decodeManager = decodeManager
    }
    
    private init() {
        decodeManager = ServerDecodeManager()
    }
    
    // MARK: - Helpers
    
    func request<T: Decodable>(for url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.timeoutInterval = Constants.timeoutInterval
        
        logger.debug("request for URL: \(url.absoluteString)")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        try handle(response: response)
        return try decodeManager.decode(data: data)
    }
    
    func data(from url: URL) async throws -> Data {
        logger.debug("request data from URL: \(url)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        try handle(response: response)
        return data
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
