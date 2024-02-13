//
//  Product.swift
//  StoreApp
//
//  Created by Ankit Rouniyar on 13/02/24.
//

import Foundation

internal struct Product: Codable {
    internal var id: Int?
    internal let title: String
    internal let price: Double
    internal let description: String
    internal let images: [String]?
    internal let category: Category
    
    // Computed property to remove escape characters from images
    internal var sanitizedImages: [String]? {
        guard let images = images else { return nil }
        return images.map { $0.removingEscapes() }
    }
}
