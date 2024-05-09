//
//  ProductsController.swift
//  Swipe-Demo
//
//  Created by Saksham Shrey on 04/05/24.
//

import Foundation
import Alamofire

protocol ProductsControllerDelegate {
    func updateProducts(productsModel: [Product])
}

struct ProductsController {
    
    var delegate: ProductsControllerDelegate?
    
     func fetchProducts() {
         Task {
             AF.request("https://app.getswipe.in/api/public/get#").responseDecodable(of: [Product].self) { response in
                 
                 switch response.result {
                     
                 case .success(let ReceivedData):
                     //                        print(ReceivedData)
                     self.delegate?.updateProducts(productsModel: ReceivedData)
                     
                 case .failure(let ReceivedError):
                     print(ReceivedError.localizedDescription)
                 }
             }
         }
    }
}
