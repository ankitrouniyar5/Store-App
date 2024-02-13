//
//  ProductImagesListView.swift
//  StoreApp
//
//  Created by Ankit Rouniyar on 13/02/24.
//

import SwiftUI

struct ProductImagesListView: View {
    
    let images: [UIImage]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack(content: {
                ForEach(images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            })
        }
    }
}

#Preview {
    ProductImagesListView(images: [])
}
