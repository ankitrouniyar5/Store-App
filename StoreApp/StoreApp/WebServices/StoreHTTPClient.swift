//
//  StoreHTTPClient.swift
//  StoreApp
//
//  Created by Ankit Rouniyar on 13/02/24.
//

import Foundation

internal enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
    case decodingError
}

internal class StoreHTTPClient {
    
    
    func getProductsByCategory(categoryId: Int) async throws -> [Product] {
        
        let (data, response) = try await URLSession.shared.data(from: URL.allProductsByCategory(categoryId))
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidServerResponse
        }
        
        guard let products = try? JSONDecoder().decode([Product].self, from: data) else {
            throw NetworkError.decodingError
        }
        return products
        
    }
    
    func getAllCategories() async throws -> [Category] {
        
        let (data, response) = try await URLSession.shared.data(from: URL.allCategories)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidServerResponse
        }
        
        guard let categories = try? JSONDecoder().decode([Category].self, from: data) else {
            throw NetworkError.decodingError
        }
        return categories
    }
    
    func createProduct(productRequest: CreateProductRequest) async throws -> Product {
        
        var request = URLRequest(url: URL.createProduct)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(productRequest)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 201 else {
            throw NetworkError.invalidServerResponse
        }
        
        guard let product = try? JSONDecoder().decode(Product.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return product
    }
    
    func deleteProduct(productId: Int) async throws -> Bool {
        var request = URLRequest(url: URL.deleteAProduct(productId))
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidServerResponse
        }
        
        guard let deleted = try? JSONDecoder().decode(Bool.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return deleted
        
    }
}
