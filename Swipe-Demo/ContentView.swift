//
//  ContentView.swift
//  Swipe-Demo
//
//  Created by Saksham Shrey on 04/05/24.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    @StateObject var productsAPI = ProductsAPI()
    @State var productsList: [Product] = []
    @State var newProduct: Product?
    
    
    @State private var selectedTab = 0
    
    
    @State private var productTypesList = ["Electronic", "Stationery", "Toys", "Tools", "Others"]
    
    
    @State private var imageURL: String = ""
    @State private var price: Double? = nil
    @State private var productName: String = ""
    @State private var productType: String = ""
    @State private var tax: Double? = nil
    
    @State private var errorMessage: String? = nil
    @State private var productAddedSuccessfully: String? = nil

    @State private var searchProduct: String = ""
    @State private var searchResult: Product? = nil
    
    @State private var isSearchActive: Bool = false
    
    
    var body: some View {
        TabView {
            VStack {
                ProductsView(products: productsList)
            }
            .onAppear(perform: {
                productsAPI.getData()
            })
            .onChange(of: productsAPI.products, { oldValue, newValue in
                self.productsList = productsAPI.products!
                print(productsList)
            })
            .padding()
            .tabItem {
                Label("Products", systemImage: "volleyball")
            }
            
            VStack {
                TextField("Image URL", text: $imageURL)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                TextField("Price", value: $price, format: .number)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                TextField("Product Name", text: $productName)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                Picker("Product Type", selection: $productType) {
                  ForEach(productTypesList, id: \.self) { product in
                    Text(product)
                  }
                }
                .padding()
                .overlay(
                  RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
                )
                TextField("Tax", value: $tax, format: .number)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                Button("Submit") {
                    newProduct = Product(image: imageURL, price: price, productName: productName, productType: productType, tax: tax)
                    
                    submitProductData()
                    
                    // Clear text fields after submit
                    imageURL = ""
                    price = nil // Assuming price is a Double
                    productName = ""
                    tax = nil // Assuming tax is a Double
                    
                }
                .font(.custom("MarkerFelt-Thin", size: 20))
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
                )
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
            }
            .tabItem {
                Label("Add Product", systemImage: "plus.app")
            }
            
            VStack {
                TextField("Enter Product Name", text: $searchProduct)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                Button("Search") {
                        searchProductAction()
                }
            }
            .font(.custom("MarkerFelt-Thin", size: 20))
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1)
            )
            .padding()
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            .sheet(isPresented: $isSearchActive) {
                if let product = searchResult {
                    VStack {
                        EachProductView(imageUrl: product.productName, price: product.price, productName: product.productName, productType: product.productType, tax: product.tax)
                            .frame(width: 400, height: 150, alignment: .center)
                    }
                } else {
                    Text("Product not found")
                }
                Button("Close") {
                    isSearchActive = false
                }
            }
            
        }
        
    }
    
    func searchProductAction() {
        let searchTerm: String
        if !searchProduct.isEmpty {
            searchTerm = searchProduct
        } else {
            return // No search term provided
        }
        
        // Filter products based on search term
        searchResult = productsList.first(where: { $0.productName!.lowercased().contains(searchTerm.lowercased()) })!
        
        isSearchActive = true
    }
    
    
    func submitProductData() {
        guard let product = newProduct,
              let urlString = product.image, !urlString.isEmpty,
              let price = product.price, price > 0,
              let productName = product.productName, !productName.isEmpty,
              let productType = product.productType, !productType.isEmpty,
              let tax = product.tax else {
            errorMessage = "Please fill in all required fields."
            return
        }
        
        DispatchQueue.main.async {
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(Data(productName.utf8), withName: "product_name")
                multipartFormData.append(Data(productType.utf8), withName: "product_type")
                multipartFormData.append(String(price).data(using: .utf8)!, withName: "price")
                multipartFormData.append(String(tax).data(using: .utf8)!, withName: "tax")
                
                // Images uploading is Optional so I have left them out for now
                if let imageUrl = URL(string: urlString) {
                    do {
                        let imageData = try Data(contentsOf: imageUrl)
                        multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                    } catch {
                        print("Error loading image: \(error.localizedDescription)")
                    }
                }
            }, to: "https://app.getswipe.in/api/public/add", method: .post)
            .responseJSON { response in
                if let error = response.error {
                    errorMessage = "Error submitting data: \(error.localizedDescription)"
                } else {
                    print(response)
                    newProduct = nil
                    errorMessage = nil
                }
            }
        }
        errorMessage = "Added Successfully"
    }
    
    
    
    
    
    
    class ProductsAPI: ProductsControllerDelegate, ObservableObject {
        
        var productController = ProductsController()
        @Published var products: [Product]?
        
        func getData() {
            productController.delegate = self
            productController.fetchProducts()
        }
        
        func updateProducts(productsModel: [Product]) {
            self.products = productsModel
        }
        
    }
}

#Preview {
    ContentView()
}
