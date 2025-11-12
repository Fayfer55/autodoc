//
//  ArticlePreviewCategoryView.swift
//  autodoc
//
//  Created by Kirill Faifer on 12.11.2025.
//

import UIKit

final class ArticlePreviewCategoryView: UIView {
    
    // MARK: - UI Elements
    
    private lazy var imageView = UIImageView()
    private lazy var label = UILabel()
    
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func addSubviews() {
        addSubview(horizontalStackView)
    }
    
    private func makeConstraints() {
        let constraints = [
            horizontalStackView.widthAnchor.constraint(equalTo: widthAnchor),
            horizontalStackView.heightAnchor.constraint(equalTo: heightAnchor)
        ]
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
}

// MARK: - Helpers

extension ArticlePreviewCategoryView {
    
    func configure(category: Article.Category) {
        imageView.image = UIImage(systemName: category.systemImage)
        label.text = category.rawValue
    }
    
}
