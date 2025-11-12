//
//  ArticlePreviewSummaryView.swift
//  autodoc
//
//  Created by Kirill Faifer on 12.11.2025.
//

import UIKit

final class ArticlePreviewSummaryView: UIView {
    
    // MARK: - UI Elements
    
    private lazy var dateLabel = UILabel()
    private lazy var titleLabel = UILabel()
    private lazy var subtitleLabel = UILabel()
    
    private lazy var categoryView = ArticlePreviewCategoryView()
    
    private lazy var horizontalStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [categoryView, dateLabel])
        return view
    }()
    
    private lazy var verticalStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [horizontalStack, titleLabel, subtitleLabel])
        view.axis = .vertical
        view.spacing = 4
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
        addSubview(verticalStack)
    }
    
    private func makeConstraints() {
        let constraints = [
            verticalStack.widthAnchor.constraint(equalTo: widthAnchor),
            verticalStack.heightAnchor.constraint(equalTo: heightAnchor)
        ]
        
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
}

// MARK: - Configure

extension ArticlePreviewSummaryView {
    
    func configure(model: ArticlePreviewModel) {
        categoryView.configure(category: model.category)
        
        dateLabel.text = model.date.description
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }
    
}
