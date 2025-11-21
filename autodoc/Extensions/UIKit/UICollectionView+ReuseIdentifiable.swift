//
//  UICollectionView+ReuseIdentifiable.swift
//  autodoc
//
//  Created by Kirill Faifer on 11.08.2025.
//

import UIKit.UICollectionView

// MARK: - UICollectionViewCell

extension UICollectionView {

    func register<T: UICollectionViewCell>(cellType: T.Type) where T: ReuseIdentifiable {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseId)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(
        withCellType type: T.Type = T.self,
        for indexPath: IndexPath
    ) -> T where T: ReuseIdentifiable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.reuseId, for: indexPath) as? T else { fatalError(dequeueError(reuseId: type.reuseId))
        }
        return cell
    }
    
    func cellForItem<T: UICollectionViewCell>(
        withCellType type: T.Type = T.self,
        at indexPath: IndexPath
    ) -> T where T: ReuseIdentifiable {
        guard let cell = cellForItem(at: indexPath) as? T else {
            fatalError(dequeueError(reuseId: type.reuseId))
        }
        return cell
    }

}

// MARK: - UICollectionReusableView

extension UICollectionView {
    
    func register<T: UICollectionReusableView>(viewType: T.Type, viewOfKind: CollectionReusableKind) where T: ReuseIdentifiable {
        register(viewType.self, forSupplementaryViewOfKind: viewOfKind.rawValue, withReuseIdentifier: viewType.reuseId)
    }
    
    func dequeueReusableView<T: UICollectionReusableView>(
        withViewType type: T.Type = T.self,
        viewOfKind: String,
        for indexPath: IndexPath
    ) -> T where T: ReuseIdentifiable {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: viewOfKind, withReuseIdentifier: type.reuseId, for: indexPath
        ) as? T else {
            fatalError(dequeueError(reuseId: type.reuseId))
        }
        return view
    }
    
    func supplementaryView<T: UICollectionReusableView>(
        withViewType type: T.Type = T.self,
        viewOfKind: CollectionReusableKind,
        at indexPath: IndexPath
    ) -> T where T: ReuseIdentifiable {
        guard let view = supplementaryView(forElementKind: viewOfKind.rawValue, at: indexPath) as? T else {
            fatalError(dequeueError(reuseId: type.reuseId))
        }
        return view
    }
    
}

// MARK: - Dequeue Error Method

extension UICollectionView {

    private func dequeueError(reuseId: String) -> String {
        "Couldn't dequeue view with identifier \(reuseId)"
    }

}
