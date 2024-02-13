//
//  ImageLoader.swift
//  StoreApp
//
//  Created by Ankit Rouniyar on 13/02/24.
//

import Foundation
import UIKit

internal final class ImageLoader {
    
    static func load(url: URL?) async -> UIImage? {
        guard let url else { return nil }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return nil
            }
            
            return UIImage(data: data)
            
        }catch {
            return nil
        }
        
    }
}
