//
//  ActivityReusableView.swift
//  autodoc
//
//  Created by Kirill Faifer on 21.11.2025.
//

import UIKit

class ActivityReusableView: UICollectionReusableView, ReuseIdentifiable {
    
    // MARK: - UI Elements
    
    lazy var activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        configureAppearance()
        addSubviews()
        makeConstraints()
    }
    
    // MARK: - Layout
    
    func configureAppearance() {
        backgroundColor = .systemBackground
        directionalLayoutMargins = .safeArea
    }
    
    func addSubviews() {
        addSubview(activityIndicatorView)
    }
    
    func makeConstraints() {
        let constraints = [
            activityIndicatorView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        activityIndicatorView.activate(constraints: constraints)
    }
        
}
