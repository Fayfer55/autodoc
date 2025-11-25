//
//  ArticlesCollectionViewController.swift
//  autodoc
//
//  Created by Kirill Faifer on 11.08.2025.
//

import UIKit
import Combine

final class ArticlesCollectionViewController: UICollectionViewController {
    
    private enum Constants {
        static let carSideImage = UIImage(systemName: "car.side.image") ?? UIImage()
    }
    
    // MARK: - DI
    
    weak var delegate: ArticlesCollectionDelegate?
    
    private let newsProvider: NewsFetchInterface
    private let layoutProvider: CollectionLayoutProtocol
    
    // MARK: - Properties
    
    private let viewModel: ArticlesCollectionViewModelInterface
    
    private var activityFooterIndexPath = IndexPath()
    private var hideActivityFooterViaError = false
    
    private var subscriptions = [AnyCancellable]()
    
    private lazy var dataSource = UICollectionViewDiffableDataSource<ArticlesCollectionSection, ArticlesCollectionRow>(collectionView: collectionView) { collectionView, indexPath, row in
        switch row {
            case let .preview(model):
                let cell: ArticlePreviewCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configure(model: model)
                return cell
        }
    }
    
    // MARK: - Lifecycle
    
    init(
        newsProvider: NewsFetchInterface,
        layoutProvider: CollectionLayoutProtocol,
        viewModel: ArticlesCollectionViewModelInterface
    ) {
        self.newsProvider = newsProvider
        self.layoutProvider = layoutProvider
        self.viewModel = viewModel
        super.init(collectionViewLayout: layoutProvider.layout(for: .current))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupParentView()
        subscribeToImages()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animateAlongsideTransition(in: collectionView) { [unowned self] _ in
            collectionView.setCollectionViewLayout(layoutProvider.layout(for: view.traitCollection), animated: false)
        }
    }
    
    // MARK: - Layout
    
    private func setupParentView() {
        collectionView.register(cellType: ArticlePreviewCollectionCell.self)
        collectionView.register(viewType: ActivityReusableView.self, viewOfKind: .footer)
        
        configureInitialSnapshot()
        configureSupplementaryViewProvider()
    }
    
    // MARK: - Private Helpers
    
    private func configureInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ArticlesCollectionSection, ArticlesCollectionRow>()
        snapshot.appendSections([.news])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func configureSupplementaryViewProvider() {
        dataSource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
            activityFooterIndexPath = indexPath
            
            let view: ActivityReusableView = collectionView.dequeueReusableView(viewOfKind: kind, for: indexPath)
            let numberOfItems = collectionView.numberOfItems(inSection: ArticlesCollectionSection.news.rawValue)
            view.isHidden = (numberOfItems == .zero) || hideActivityFooterViaError || !newsProvider.nextPageNeeded
            
            if !view.isHidden {
                view.activityIndicatorView.startAnimating()
                fetchNextPage()
            }
            return view
        }
    }
    
    private func subscribeToImages() {
        viewModel.imagePublisher
            .sink { [weak self] image, indexPath in
                guard let self else { return }
                guard collectionView.indexPathsForVisibleItems.contains(indexPath) else { return }
                let cell: ArticlePreviewCollectionCell = collectionView.cellForItem(at: indexPath)
                if let image {
                    cell.configure(image: image)
                } else {
                    cell.configure(image: Constants.carSideImage)
                }
            }
            .store(in: &subscriptions)
    }
    
    private func stringFromDate(_ date: Date) -> String {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            return date.formatted(date: .omitted, time: .shortened)
        } else if let yearFromToday = calendar.date(byAdding: .year, value: 1, to: .now), date > yearFromToday {
            return date.formatted(date: .abbreviated, time: .omitted)
        } else {
            return date.formatted(dateFormat: .ddMMMM)
        }
    }
    
    private func fetchNextPage() {
        Task {
            do {
                try await newsProvider.nextPage()
            } catch {
                let view: ActivityReusableView = collectionView.supplementaryView(
                    viewOfKind: .footer, at: activityFooterIndexPath
                )
                view.isHidden = true // just hide loading for user
                hideActivityFooterViaError = true // can send some analytics for development
            }
        }
    }
    
}

// MARK: - Helpers

extension ArticlesCollectionViewController {
    
    func append(articles: [Article]) {
        let rows: [ArticlesCollectionRow] = articles.map {
            .preview(ArticlePreviewModel(
                title: $0.title,
                subtitle: $0.description,
                imageURL: URL(string: $0.titleImageUrl ?? .empty),
                date: stringFromDate($0.publishedDate),
                category: $0.category,
                articleURL: $0.fullUrl
            ))
        }
        
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(rows, toSection: .news)
        dataSource.apply(snapshot)
    }
    
}

// MARK: - UICollectionViewDelegate

extension ArticlesCollectionViewController {
    
    override func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let cell = cell as? ArticlePreviewCollectionCell else { return }
        let items = dataSource.snapshot().itemIdentifiers(inSection: .news)
        if items.indices.contains(indexPath.item), case let .preview(model) = items[indexPath.item],
           let imageURL = model.imageURL, cell.imageView.image == nil {
            cell.activityIndicator.startAnimating()
            viewModel.image(at: indexPath, for: imageURL)
        }
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let cell = cell as? ArticlePreviewCollectionCell, cell.activityIndicator.isAnimating else { return }
        let items = dataSource.snapshot().itemIdentifiers(inSection: .news)
        if items.indices.contains(indexPath.item), case let .preview(model) = items[indexPath.item],
           let imageURL = model.imageURL {
            cell.activityIndicator.stopAnimating()
            viewModel.cancelImageFetch(for: imageURL)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let items = dataSource.snapshot().itemIdentifiers(inSection: .news)
        guard case let .preview(model) = items[indexPath.item] else { return }
        delegate?.articleDidSelect(for: model)
    }
    
}
