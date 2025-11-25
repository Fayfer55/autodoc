//
//  ArticlesCollectionLayoutManager.swift
//  autodoc
//
//  Created by Kirill Faifer on 25.11.2025.
//

import UIKit.UICollectionViewLayout

struct ArticlesCollectionLayoutManager: CollectionLayoutProtocol {
    
    // MARK: - Constants
    
    private enum Constants {
        static let estimatedCollectionItemHeight: CGFloat = 300
        static let estimatedCollectionFooterHeight: CGFloat = 50
        static let itemsInARowForPortraitPad: Int = 2
        static let itemsInARowForLandscapePad: Int = 3
        static let articlesCollectionFooter: NSCollectionLayoutBoundarySupplementaryItem = {
            let footerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(Constants.estimatedCollectionFooterHeight)
            )
            return NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: footerSize,
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom
            )
        }()
    }
    
    // MARK: - CollectionLayoutProtocol
    
    func layout(for trait: UITraitCollection) -> UICollectionViewLayout {
        if trait.userInterfaceIdiom == .phone {
            return articlesCollectionLayoutForPhone(trait: trait)
        } else {
            return articlesCollectionLayoutForPad()
        }
    }
    
    // MARK: - Private Helpers
    
    private func articlesCollectionLayoutForPhone(trait: UITraitCollection) -> UICollectionViewCompositionalLayout {
        let isPortraitOrientation = trait.verticalSizeClass == .regular
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(isPortraitOrientation ? 1 : 0.5),
            heightDimension: .estimated(Constants.estimatedCollectionItemHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Constants.estimatedCollectionItemHeight)
        )
        let group: NSCollectionLayoutGroup
        if isPortraitOrientation {
            group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        } else {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        }
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [Constants.articlesCollectionFooter]
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func articlesCollectionLayoutForPad() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, environment in
            let contentSize = environment.container.effectiveContentSize
            let isPortraitOrientation = contentSize.height > contentSize.width
            let itemsInARow = isPortraitOrientation ? Constants.itemsInARowForPortraitPad : Constants.itemsInARowForLandscapePad
            
            let itemWidth = contentSize.width / CGFloat(itemsInARow)
            let itemSpacing = (contentSize.width - itemWidth * CGFloat(itemsInARow)) / CGFloat(itemsInARow - 1)
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .absolute(itemWidth),
                heightDimension: .estimated(Constants.estimatedCollectionItemHeight)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(Constants.estimatedCollectionItemHeight)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(itemSpacing)
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [Constants.articlesCollectionFooter]
            return section
        }
    }
    
}
