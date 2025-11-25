//
//  CollectionLayoutProtocol.swift
//  autodoc
//
//  Created by Kirill Faifer on 25.11.2025.
//

import UIKit.UICollectionViewLayout

@MainActor
protocol CollectionLayoutProtocol {
    func layout(for trait: UITraitCollection) -> UICollectionViewLayout
}
