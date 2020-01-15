//
//  BasketViewController.swift
//  ETicApp
//
//  Created by Bilal Candemir on 1.12.2019.
//  Copyright © 2019 Bilal Candemir. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView
import AVFoundation
class BasketViewController: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var TotalPriceLabel: UILabel!
    @IBOutlet weak var CompleteOrderButton: UIButton!
    @IBAction func CompleteOrder(_ sender: Any) {
        deleteProduct { (succes) in
            if succes{
                self.CompleteOrderButton.alpha = 0  //Sepet Boş ise complete order butonu görünmez yapıldı
                self.getData { (succes) in
                    if succes{
                        self.tableView.reloadData() //Ürün silindikten sonra tableViewi Handler ile reload etmeme rağmen ürün sepetten çıkıp girince yok oluyor
                    }
                }
            }
        }
        }
    
    
    
    let ref = Database.database().reference().child("Basket")
    var Basket = [String]()
    var TotalPrice = [Int]()
    var Toplam = 0
    var choosenNumber = Int()
    var productviewmodel = ProductViewModel()
    var basket1 = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let size = CGSize(width: 30.0, height: 30.0)
        self.startAnimating(size, message: "Yükleniyor", color: .blue, textColor: .white, fadeInAnimation: nil)
        
        CompleteOrderButton.alpha = 0
        
        self.title = "Sepet"
        tableView.dataSource = self
        tableView.delegate = self
        
        self.productviewmodel.basketLoad { (succes) in  //MVVM biraz karıştı ama :)
            if succes{
                self.basket1 = self.productviewmodel.basket
                self.stopAnimating()
            }
            
        }

        if Basket.count == 0{
            self.stopAnimating()
        }
        
        getData { (succes) in
            if succes{
                self.tableView.reloadData()
            }
        }
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Basket.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let products = productviewmodel.basket[indexPath.row]     // Load işlemini view model ile yapma
        let product = Basket[indexPath.row]
        self.Toplam = self.Toplam + TotalPrice[indexPath.row]
        TotalPriceMethod(x: self.Toplam)
        let cell = UITableViewCell()
        cell.textLabel?.text = product
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            ref.child("\(choosenNumber)").removeValue { (error, DatabaseReference) in    //Değişecek
                if error != nil{
                    print("error")
                }
            }
            
            Basket.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            self.Toplam =  self.Toplam - self.TotalPrice[indexPath.row]
            if self.Toplam > 0{
                self.TotalPriceLabel.text = "Borcunuz " + String(self.Toplam) + " TL"
            }
            else{
                self.TotalPriceLabel.text = "Sepetiniz Boş!"
            }
            
        }
    }
    
    
    func deleteProduct(complation: @escaping (_ succes:Bool) -> ()){
        self.ref.removeValue()
        self.TotalPriceLabel.text = "Ürünler için geri dön!"
        let alert = UIAlertController(title: "İşlem Başarılı", message: "Bizi Tercih ettiğiniz için Teşekkür Ederiz", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction (title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
        complation(true)
    }
    
    
    func getData(complation: @escaping (_ succes:Bool) -> ()){
        ref.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as? NSDictionary
            let name = snapshotValue?["ProductName"] as? String ?? ""
            let price = snapshotValue?["ProductPrice"] as? Int ?? 0
            self.Basket.append(name)
            self.TotalPrice.append(price)
            self.stopAnimating()
            self.CompleteOrderButton.alpha = 1
            complation(true)
        }
    }
    func TotalPriceMethod(x:Int){       //Hala Daha düzgün bir method yazamadım ancak şu anda total price labelında doğru değerler gözüküyor.
        self.TotalPriceLabel.text = "Borcunuz: " + String(x) + " TL"
    }
    
}
