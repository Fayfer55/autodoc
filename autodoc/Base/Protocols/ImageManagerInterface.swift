//
//  ImageManagerInterface.swift
//  autodoc
//
//  Created by Kirill Faifer on 12.08.2025.
//

import Foundation
import UIKit.UIImage

protocol ImageManagerInterface {
    func image(for url: URL?) async throws -> UIImage
    func cancelFetching(for url: URL) async
}
