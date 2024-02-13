//
//  String+Extensions.swift
//  StoreApp
//
//  Created by Ankit Rouniyar on 13/02/24.
//

import Foundation

extension String {
    func removingEscapes() -> String {
        // Remove backslashes
        var result = self.replacingOccurrences(of: "\\", with: "")
        // Remove square brackets and double quotes
        result = result.replacingOccurrences(of: "[\"", with: "")
        result = result.replacingOccurrences(of: "\"]", with: "")
        return result
    }
}
