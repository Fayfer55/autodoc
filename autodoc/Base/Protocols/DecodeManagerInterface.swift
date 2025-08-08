//
//  DecodeManagerInterface.swift
//  autodoc
//
//  Created by Kirill Faifer on 08.08.2025.
//

import Foundation

protocol DecodeManagerInterface {
    func decode<T: Decodable>(data: Data) throws -> T
}
