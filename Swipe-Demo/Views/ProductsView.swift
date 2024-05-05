//
//  SwiftUIView.swift
//  Swipe-Demo
//
//  Created by Saksham Shrey on 04/05/24.
//

import SwiftUI

struct ProductsView: View {
    var products: [Product]
    var body: some View {
        VStack {
            VStack {
                ScrollView {
                    ForEach(products, id: \.self) {product in
                        EachProductView(imageUrl: product.image, price: product.price, productName: product.productName, productType: product.productType, tax: product.tax)
                        Divider()
                    }
                }
            }
        }
    }
}

//#Preview {
//    ProductsView()
//}
