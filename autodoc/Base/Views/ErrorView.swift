//
//  ErrorView.swift
//  autodoc
//
//  Created by Kirill Faifer on 18.11.2025.
//

import UIKit

final class ErrorView: UIView {
    
    private enum Constants {
        static let title = "Что-то пошло не так"
        static let buttonTitle = "Повторить"
        static let titleLabelFontSize: CGFloat = 24
        static let descriptionLabelFontSize: CGFloat = 17
        static let textStackViewSpacing: CGFloat = 8
    }
    
    // MARK: - UI Elements
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.title
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: Constants.titleLabelFontSize)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.descriptionLabelFontSize)
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()
    
    lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = Constants.textStackViewSpacing
        return stackView
    }()
    
    lazy var retryButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.configuration?.cornerStyle = .capsule
        button.configuration?.baseBackgroundColor = .systemBlue
        button.configuration?.title = Constants.buttonTitle
        button.configuration?.baseForegroundColor = .systemBackground
        return button
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textStackView, retryButton])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
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
        addSubview(mainStackView)
    }
    
    private func makeConstraints() {
        let constraints = [
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        mainStackView.activate(constraints: constraints)
    }
    
}
