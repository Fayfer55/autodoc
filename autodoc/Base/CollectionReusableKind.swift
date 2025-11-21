//
//  CollectionReusableKind.swift
//  autodoc
//
//  Created by Kirill Faifer on 21.11.2025.
//

import UIKit.UICollectionView

enum CollectionReusableKind: RawRepresentable {
    
    case header, footer
    
    var rawValue: String {
        switch self {
            case .header:
                UICollectionView.elementKindSectionHeader
            case .footer:
                UICollectionView.elementKindSectionFooter
        }
    }
    
    init?(rawValue: String) {
        switch rawValue {
            case UICollectionView.elementKindSectionHeader:
                self = .header
            case UICollectionView.elementKindSectionFooter:
                self = .footer
            default:
                return nil
        }
    }
                        
}
