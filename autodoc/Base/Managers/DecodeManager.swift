//
//  DecodeManager.swift
//  autodoc
//
//  Created by Kirill Faifer on 08.08.2025.
//

import Foundation
import OSLog

struct DecodeManager: DecodeManagerInterface {
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    // MARK: - Helpers
    
    func decode<T: Decodable>(data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }
    
}
