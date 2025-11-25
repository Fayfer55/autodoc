//
//  ArticlePreviewCollectionCell.swift
//  autodoc
//
//  Created by Kirill Faifer on 12.08.2025.
//

import UIKit

final class ArticlePreviewCollectionCell: LoadingImageCollectionCell {
    
    private enum Constants {
        static let imageViewCornerRadius: CGFloat = 16
        static let stackViewSpacing: CGFloat = 4
        static let imageViewHeightMultiplier: CGFloat = 9 / 16
    }
    
    // MARK: - UI Elements
    
    private lazy var summaryView = ArticlePreviewSummaryView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [summaryView, imageView])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()
    
    // MARK: - Layout
    
    override func configureAppearance() {
        super.configureAppearance()
        
        contentView.directionalLayoutMargins = .safeArea
        configureImageViewAppearance()
    }
    
    override func addSubviews() {
        imageView.addSubview(activityIndicator)
        contentView.addSubview(stackView)
    }
    
    override func makeConstraints() {
        activateStackViewConstraints()
        activateImageViewConstraints()
        activateActivityIndicatorConstraints()
    }
    
    private func configureImageViewAppearance() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = Constants.imageViewCornerRadius
    }
    
    private func activateStackViewConstraints() {
        let constraints = [
            stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ]
        stackView.activate(constraints: constraints)
    }
    
    private func activateImageViewConstraints() {
        let constraints = [
            imageView.widthAnchor.constraint(equalTo: contentView.layoutMarginsGuide.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: Constants.imageViewHeightMultiplier)
        ]
        imageView.activate(constraints: constraints)
    }
    
    private func activateActivityIndicatorConstraints() {
        let constraints = [
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ]
        activityIndicator.activate(constraints: constraints)
    }
    
}

// MARK: - Configure

extension ArticlePreviewCollectionCell {
    
    func configure(model: ArticlePreviewModel) {
        imageView.image = nil
        imageView.isHidden = model.imageURL == nil
        summaryView.configure(model: model)
    }
    
}
