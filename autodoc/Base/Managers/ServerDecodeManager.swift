//
//  ServerDecodeManager.swift
//  autodoc
//
//  Created by Kirill Faifer on 08.08.2025.
//

import Foundation
import OSLog

final class ServerDecodeManager: DecodeManagerInterface {
    
    private enum Constants {
        static let serverDateLocale = Locale(identifier: "en_US_POSIX")
        static let serverTimeZone = TimeZone(secondsFromGMT: 0)
    }
    
    // MARK: - Properties
    
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.server.rawValue
        formatter.locale = Constants.serverDateLocale
        formatter.timeZone = Constants.serverTimeZone
        return formatter
    }()
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()
    
    // MARK: - Helpers
    
    func decode<T: Decodable>(data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }
    
}
