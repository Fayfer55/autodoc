//
//  BaseCollectionCell.swift
//  autodoc
//
//  Created by Kirill Faifer on 12.11.2025.
//

import Foundation
import UIKit

class BaseCollectionCell: UICollectionViewCell, ReuseIdentifiable {
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        configureAppearance()
        addSubviews()
        makeConstraints()
    }
    
    // MARK: - Layout
    
    func configureAppearance() {
        contentView.backgroundColor = .systemBackground
    }
    
    func addSubviews() {}
    
    func makeConstraints() {}
    
}
