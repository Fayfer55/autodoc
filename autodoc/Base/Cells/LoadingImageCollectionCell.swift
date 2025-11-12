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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupCell()
    }
    
    private func setupCell() {
        configureAppearance()
        addSubviews()
        makeConstraints()
        
        activityIndicator.startAnimating()
    }
    
    // MARK: - Layout
    
    override func addSubviews() {
        contentView.addSubviews(imageView, activityIndicator)
    }
    
    override func makeConstraints() {
        let imageViewConstraints = [
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ]
        let activityIndicatorConstraints = [
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(activityIndicatorConstraints)
    }
    
}

// MARK: - Configure

extension LoadingImageCollectionCell {
    
    func configure(image: UIImage) {
        imageView.image = image
        activityIndicator.stopAnimating()
    }
    
}
