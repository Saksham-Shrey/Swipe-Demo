//
//  ProductView.swift
//  Swipe-Demo
//
//  Created by Saksham Shrey on 04/05/24.
//

import SwiftUI

struct EachProductView: View {
    var imageUrl: String?
    var price: Double?
    var productName: String?
    var productType: String?
    var tax: Double?
    var body: some View {
        VStack {
            HStack {
                    AsyncImage(url: URL(string: (imageUrl != "" ? imageUrl : nil) ??  "https://permacultureprinciples.com/wp-content/uploads/2013/01/Pc-Icons-Principle-9.gif"),
                               content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 160, maxHeight: 160)
                            .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    },
                               placeholder: {
                        ProgressView()
                    }
                    )
                Spacer()
                
                VStack() {
                    Text("\(productName ?? "NIL")")
                        .font(.custom("MarkerFelt-Thin", size: 16))
                        .minimumScaleFactor(0.1)
                    Text("(\(productType ?? "NIL"))")
                        .minimumScaleFactor(0.1)
                    
                    Spacer()
                    
                    Text("Price: \(String(format: "%.2f", price ?? "0"))")
                        .minimumScaleFactor(0.1)
                    Text("Tax: \(String(format: "%.2f", tax ?? "0"))")
                        .minimumScaleFactor(0.1)
                    
                }
            }
            .padding()
        }
    }
}

#Preview {
    EachProductView()
}
