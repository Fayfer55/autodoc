//
//  Article.swift
//  autodoc
//
//  Created by Kirill Faifer on 08.08.2025.
//

import Foundation

struct Article: Decodable {
    
    let id: Int
    let title: String
    let description: String
    let publishedDate: Date
    let url: String
    let fullUrl: String
    let titleImageUrl: String?
    let category: Category
    
    private enum CodingKeys: String, CodingKey {
        case id, title, description, url
        case titleImageUrl
        case fullUrl
        case publishedDate
        case category = "categoryType"
    }
    
}

// MARK: - Decodable

extension Article {
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        publishedDate = try container.decode(Date.self, forKey: .publishedDate)
        url = try container.decode(String.self, forKey: .url)
        fullUrl = try container.decode(String.self, forKey: .fullUrl)
        titleImageUrl = try container.decodeIfPresent(String.self, forKey: .titleImageUrl)
        category = try container.decode(Category.self, forKey: .category)
    }
    
}

// MARK: - Category

extension Article {
    
    enum Category: Decodable, RawRepresentable, Hashable {
        case vehicle, company
        case unknown(String)
        
        var systemImage: String {
            switch self {
                case .vehicle:
                    "car"
                case .company:
                    "gearshape.fill"
                case .unknown:
                    "number"
            }
        }
        
        // MARK: - Category RawRepresentable
        
        var rawValue: String {
            switch self {
                case .vehicle:
                    CodingKeys.vehicle.rawValue
                case .company:
                    CodingKeys.company.rawValue
                case .unknown(let value):
                    value
            }
        }
        
        init(rawValue: String) {
            switch rawValue {
                case CodingKeys.vehicle.rawValue:
                    self = .vehicle
                case CodingKeys.company.rawValue:
                    self = .company
                default:
                    self = .unknown(rawValue)
            }
        }
        
        // MARK: - Category Decodable
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)
            self.init(rawValue: value)
        }
        
        private enum CodingKeys: String, CodingKey {
            case vehicle = "Автомобильные новости"
            case company = "Новости компании"
            case unknown
        }
    }
    
}
