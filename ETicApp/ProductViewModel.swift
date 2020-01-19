//
//  ProductViewModel.swift
//  ETicApp
//
//  Created by Bilal Candemir on 20.11.2019.
//  Copyright © 2019 Bilal Candemir. All rights reserved.
//

import Foundation
import Firebase
import SDWebImage
class ProductViewModel{
    let ref = Database.database().reference().child("Products")
    let basketRef = Database.database().reference().child("Basket")
    var basket = [String]()
    var basketPrice = [Int]()
    
    
    var productList = [Proudcts]()
    var Names = [String]()
    var prices = [Int]()
    var ID = [Int]()
    var image = [String]()
    init() {}
    
    func load(complation: @escaping (_ succes:Bool) -> ()){
        ref.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as? NSDictionary
            let id = snapshotValue?["id"] as? Int ?? 0
            let name = snapshotValue?["Name"] as? String ?? ""
            let price = snapshotValue?["price"] as? Int ?? 0
            let image = snapshotValue?["imagePath"] as? String ?? ""
            let item = Proudcts(id: id, name: name, price: price, image: image)
            self.prices.append(price)
            self.productList.append(item)
            self.Names.append(name)
            self.ID.append(id)
            self.image.append(image)
            complation(true)
        }
    }
    
    func basketLoad(complation: @escaping (_ succes:Bool) -> ()){
        basketRef.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as? NSDictionary
            let name = snapshotValue?["ProductName"] as? String ?? ""
            let price = snapshotValue?["ProductPrice"] as? Int ?? 0
            self.basket.append(name)
            self.basketPrice.append(price)
            complation(true)
        }
    }
}

