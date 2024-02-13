//
//  CreateProductRequest.swift
//  StoreApp
//
//  Created by Ankit Rouniyar on 13/02/24.
//

import Foundation

internal struct CreateProductRequest: Encodable {
    internal let title: String
    internal let price: Double
    internal let description: String
    internal let images: [String]?
    internal let categoryId: Int
    
    internal init(product: Product) {
        self.title = product.title
        self.price = product.price
        self.description = product.description
        self.images = product.images
        self.categoryId = product.category.id
    }
    
}
