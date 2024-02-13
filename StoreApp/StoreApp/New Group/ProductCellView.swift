//
//  ProductCellView.swift
//  StoreApp
//
//  Created by Ankit Rouniyar on 13/02/24.
//

import SwiftUI

struct ProductCellView: View {
    
    let product: Product
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 10, content: {
                Text(product.title).bold()
                Text(product.description).lineLimit(2)
            })
            Spacer()
            Text(product.price, format: .currency(code: "INR"))
                .padding(10)
                .background {
                    Color.green
                }.clipShape(RoundedRectangle(cornerRadius: 10))
        }.padding(20)
            
    }
}

#Preview {
    ProductCellView(product: Product(id: 1, title: "title", price: 1234, description: "title title title title", images: [URL(string: "https://www.google.com/aclk?sa=l&ai=DChcSEwi71tT996eEAxUmIoMDHW64AWgYABABGgJzZg&ase=2&gclid=Cj0KCQiAw6yuBhDrARIsACf94RXkOouRdnI0KM6nuEmhDS1rG7xRvRmyzO7GhNDhYGKF_nfFXvT4m7caAvcFEALw_wcB&sig=AOD64_3NipkWAhGqBZ9anGtwwvwhqlgiOA&ctype=5&q=&nis=4&ved=2ahUKEwjw683996eEAxV-b2wGHWYbDwUQ9aACKAB6BAgBEA4&adurl=")!], category: Category(id: 1, name: "clothers", image: "https://www.google.com/aclk?sa=l&ai=DChcSEwi71tT996eEAxUmIoMDHW64AWgYABABGgJzZg&ase=2&gclid=Cj0KCQiAw6yuBhDrARIsACf94RXkOouRdnI0KM6nuEmhDS1rG7xRvRmyzO7GhNDhYGKF_nfFXvT4m7caAvcFEALw_wcB&sig=AOD64_3NipkWAhGqBZ9anGtwwvwhqlgiOA&ctype=5&q=&nis=4&ved=2ahUKEwjw683996eEAxV-b2wGHWYbDwUQ9aACKAB6BAgBEA4&adurl=")))
}
