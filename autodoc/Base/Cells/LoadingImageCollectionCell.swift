//
//  AsyncImageCollectionCell.swift
//  autodoc
//
//  Created by Kirill Faifer on 12.08.2025.
//

import UIKit

class LoadingImageCollectionCell: BaseCollectionCell {
    
    // MARK: - UI Elements
    
    lazy var imageView = UIImageView()
    lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    private func setupCell() {
        configureAppearance()
        addSubviews()
        makeConstraints()
    }
    
    // MARK: - Layout
    
    override func addSubviews() {
        imageView.addSubview(activityIndicator)
        contentView.addSubviews(imageView)
    }
    
    override func makeConstraints() {
        activateImageViewConstraints()
        activateActivityIndicatorConstraints()
        
    }
    
    private func activateImageViewConstraints() {
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        imageView.activate(constraints: imageViewConstraints)
    }
    
    private func activateActivityIndicatorConstraints() {
        let activityIndicatorConstraints = [
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ]
        activityIndicator.activate(constraints: activityIndicatorConstraints)
    }
    
}

// MARK: - Configure

extension LoadingImageCollectionCell {
    
    func configure(image: UIImage) {
        imageView.image = image
        activityIndicator.stopAnimating()
    }
    
}
