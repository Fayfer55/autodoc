//
//  ArticlePreviewSummaryView.swift
//  autodoc
//
//  Created by Kirill Faifer on 12.11.2025.
//

import UIKit

final class ArticlePreviewSummaryView: UIView {
    
    // MARK: - UI Elements
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var categoryView = ArticlePreviewCategoryView()
    
    private lazy var horizontalStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [categoryView, dateLabel])
        view.distribution = .equalCentering
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
            verticalStack.topAnchor.constraint(equalTo: topAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        verticalStack.activate(constraints: constraints)
    }
    
}

// MARK: - Configure

extension ArticlePreviewSummaryView {
    
    func configure(model: ArticlePreviewModel) {
        categoryView.configure(category: model.category)
        
        dateLabel.text = model.date
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }
    
}
