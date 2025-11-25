//
//  WebViewController.swift
//  autodoc
//
//  Created by Kirill Faifer on 25.11.2025.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    let stringURL: String
    
    // MARK: - UI Elements
    
    private var webView: WKWebView!
    
    // MARK: - Lifecycle
    
    init(stringURL: String) {
        self.stringURL = stringURL
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupParentView()
    }
    
    // MARK: - Layout
    
    private func setupParentView() {
        if let url = URL(string: stringURL) {
            webView.load(URLRequest(url: url))
        }
    }
    
}
