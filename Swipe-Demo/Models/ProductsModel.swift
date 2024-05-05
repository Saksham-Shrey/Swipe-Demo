//
//  ProductsModel.swift
//  Swipe-Demo
//
//  Created by Saksham Shrey on 04/05/24.
//

import Foundation

struct Product: Codable, Equatable, Identifiable, Hashable {
    var id: ObjectIdentifier?
    var image: String?
    var price: Double?
    var productName: String?
    var productType: String?
    var tax: Double?
    
    enum CodingKeys: String, CodingKey {
        case image
        case price
        case productName = "product_name"
        case productType = "product_type"
        case tax
    }
}
