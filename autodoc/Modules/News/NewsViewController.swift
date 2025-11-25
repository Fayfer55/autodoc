//
//  NewsViewController.swift
//  autodoc
//
//  Created by Kirill Faifer on 08.08.2025.
//

import UIKit
import Combine

final class NewsViewController: UIViewController {
    
    private let viewModel: NewsViewModelInterface
    
    private var subscription: AnyCancellable?
    
    // MARK: - UI Elements
    
    private let articlesCollection: ArticlesCollectionViewController
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.isHidden = true
        view.retryButton.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
        return view
    }()
    
    // MARK: - Lifecycle
    
    init(viewModel: NewsViewModelInterface, articlesCollection: ArticlesCollectionViewController) {
        self.viewModel = viewModel
        self.articlesCollection = articlesCollection
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupParentView()
        addSubviews()
        makeConstraints()
        subscribeToArticles()
        
        activityIndicator.startAnimating()
        fetchArticles()
    }
    
    // MARK: - Layout
    
    private func setupParentView() {
        view.directionalLayoutMargins = .safeArea
    }
    
    private func addSubviews() {
        addChild(articlesCollection)
        view.addSubview(articlesCollection.view)
        view.addSubview(activityIndicator)
        view.addSubview(errorView)
        
        articlesCollection.didMove(toParent: self)
    }
    
    private func makeConstraints() {
        activateArticlesCollectionConstraints()
        activateActivityIndicatorConstraints()
        activateErrorViewConstraints()
    }
    
    private func activateArticlesCollectionConstraints() {
        let constraints = [
            articlesCollection.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            articlesCollection.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            articlesCollection.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            articlesCollection.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        articlesCollection.view.activate(constraints: constraints)
    }
    
    private func activateActivityIndicatorConstraints() {
        let constraints = [
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        activityIndicator.activate(constraints: constraints)
    }
    
    private func activateErrorViewConstraints() {
        let constraints = [
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.directionalLayoutMargins.top),
            errorView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.directionalLayoutMargins.bottom)
        ]
        errorView.activate(constraints: constraints)
    }
    
    // MARK: - Private Helpers
    
    private func subscribeToArticles() {
        subscription = viewModel.articlesPublisher
            .sink { [unowned self] articles in
                activityIndicator.stopAnimating()
                articlesCollection.append(articles: articles)
            }
    }
    
    private func fetchArticles() {
        Task {
            do {
                try await viewModel.fetch()
            } catch {
                activityIndicator.stopAnimating()
                errorView.descriptionLabel.text = error.localizedDescription
                errorView.isHidden = false
            }
        }
    }
    
    @objc
    private func retryAction() {
        errorView.isHidden = true
        activityIndicator.startAnimating()
        fetchArticles()
    }
    
}
