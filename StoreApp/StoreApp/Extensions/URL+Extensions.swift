//
//  URL+Extensions.swift
//  StoreApp
//
//  Created by Ankit Rouniyar on 13/02/24.
//

import Foundation

extension URL {
    
    static var development: URL {
        URL(string: "https://api.escuelajs.co/")!
    }
    
    static var production: URL {
        URL(string: "https://api.escuelajs.co/")!
    }
    
    static var `default`: URL {
        #if DEBUG
        return development
        #else
        return production
        #endif
    }
    
    static var allCategories: URL {
        URL(string: "/api/v1/categories", relativeTo: Self.default)!
    }
    
    static func allProductsByCategory(_ categoryId: Int) -> URL {
        URL(string: "api/v1/categories/\(categoryId)/products", relativeTo: Self.default)!
    }
    
    static var createProduct: URL {
        URL(string: "api/v1/products/", relativeTo: Self.default)!
    }
    
    static func deleteAProduct(_ productId: Int) -> URL {
        URL(string: "api/v1/products/\(productId)", relativeTo: Self.default)!
    }
}
