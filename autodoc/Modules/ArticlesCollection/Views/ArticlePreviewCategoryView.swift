//
//  ArticlePreviewCategoryView.swift
//  autodoc
//
//  Created by Kirill Faifer on 12.11.2025.
//

import UIKit

final class ArticlePreviewCategoryView: UIView {
    
    // MARK: - UI Elements
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        return view
    }()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemProRoundedFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageView, label])
        view.axis = .horizontal
        view.spacing = 2
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func addSubviews() {
        addSubview(horizontalStackView)
    }
    
    private func makeConstraints() {
        let constraints = [
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        horizontalStackView.activate(constraints: constraints)
    }
    
    private func activateImageViewConstraints() {
        let constraints = [
            imageView.widthAnchor.constraint(equalToConstant: 18),
            imageView.heightAnchor.constraint(equalToConstant: 18)
        ]
        imageView.activate(constraints: constraints)
    }
    
}

// MARK: - Helpers

extension ArticlePreviewCategoryView {
    
    func configure(category: Article.Category) {
        imageView.image = UIImage(systemName: category.systemImage)
        label.text = category.rawValue
    }
    
}
