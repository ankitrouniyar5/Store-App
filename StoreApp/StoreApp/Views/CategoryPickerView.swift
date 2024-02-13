//
//  CategoryPickerView.swift
//  StoreApp
//
//  Created by Ankit Rouniyar on 13/02/24.
//

import SwiftUI

struct CategoryPickerView: View {
    
    private let client = StoreHTTPClient()
    @State private var categories: [Category] = []
    @State private var selectedCategory: Category?
    
    internal let onSelected: (Category) -> Void
    var body: some View {
        Picker("Categories", selection: $selectedCategory) {
            ForEach(categories, id: \.id) { category in
                Text(category.name).tag(Optional(category))
            }
        }.onChange(of: selectedCategory, perform: { category in
            if let category {
                onSelected(category)
            }
        })
        .pickerStyle(.wheel)
            .task {
                do {
                    categories = try await client.getAllCategories()
                    selectedCategory = categories.first
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
}

#Preview {
    CategoryPickerView(onSelected: { _ in})
}
