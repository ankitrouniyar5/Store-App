//
//  Product.swift
//  StoreApp
//
//  Created by Ankit Rouniyar on 13/02/24.
//

import Foundation

internal struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let images: [URL]?
    let category: Category
}
