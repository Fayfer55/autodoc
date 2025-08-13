//
//  NetworkManagerInterface.swift
//  autodoc
//
//  Created by Kirill Faifer on 08.08.2025.
//

import Foundation

protocol NetworkManagerInterface {
    func request<T: Decodable>(for url: URL) async throws -> T
    func data(from url: URL) async throws -> Data
}
