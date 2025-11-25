//
//  WebFactory.swift
//  autodoc
//
//  Created by Kirill Faifer on 25.11.2025.
//

import UIKit.UIViewController

struct WebFactory {
    
    static func makeWebViewModule(stringURL: String) -> UIViewController {
        WebViewController(stringURL: stringURL)
    }
    
}
