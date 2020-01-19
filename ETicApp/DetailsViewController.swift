//
//  DetailsViewController.swift
//  ETicApp
//
//  Created by Bilal Candemir on 29.11.2019.
//  Copyright © 2019 Bilal Candemir. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView
import SDWebImage
class DetailsViewController: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var addBasket: UIButton!
    
    @IBAction func add(_ sender: Any) {
        getBasketData { (succes) in
            self.startAnimating()
            if succes{
                self.stopAnimating()
                self.alert()
            }
        }
    }
    @IBOutlet weak var productPriceLabel: UILabel!
    var choosenIndex = Int()
    var selectedProductNames = ""
    var selectedProductPrice = Int()
    var selectedImageUrl = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        productNameLabel.text = selectedProductNames
        productPriceLabel.text = String(selectedProductPrice) + "TL"
        self.title = selectedProductNames
        productImage.sd_setImage(with: URL(string: selectedImageUrl[choosenIndex - 1]))
        self.navigationController?.navigationBar.tintColor = Color.tintColor
        addBasket.tintColor = Color.textColor
        addBasket.backgroundColor = Color.tintColor
        addBasket.layer.cornerRadius = 5
    }
    
 


}
//Functions
extension DetailsViewController{
    func alert(){
         let alert = UIAlertController(title: "İşlem Başarılı", message: "Ürün Sepetinize Eklendi", preferredStyle: UIAlertController.Style.alert)
         alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
         self.present(alert, animated: true)
     }
     
     func getBasketData(complation: @escaping (_ succes:Bool) -> ()){
         let size = CGSize(width: 30.0, height: 30.0)
         self.startAnimating(size, message: "Yükleniyor", color: .blue, textColor: .white, fadeInAnimation: nil)
         let ref = Database.database().reference().child("Basket")
         let basketInfo = ["ProductName": selectedProductNames, "ProductPrice": selectedProductPrice] as [String : Any]
         ref.child("\(choosenIndex)").setValue(basketInfo)
         complation(true)
     }
}
