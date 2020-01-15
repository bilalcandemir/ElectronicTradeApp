//
//  ProductViewController.swift
//  ETicApp
//
//  Created by Bilal Candemir on 20.11.2019.
//  Copyright © 2019 Bilal Candemir. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView
import SDWebImage
class ProductViewController: UIViewController, NVActivityIndicatorViewable{
    
    @IBOutlet weak var tableView: UITableView!
    
    var productviewmodel = ProductViewModel()
    var choosenName = ""
    var image = [UIImage]()  //Image dizisi
    var choosenPrice = Int()
    var choosenIndex = Int()
    var imageUrl = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = Color.tintColor
        self.navigationItem.title = "Ürünler"
        self.navigationItem.hidesBackButton = true
        
        //Navigation Item ile düzeltildi & resimde png kullanımı kaldırıldı
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "basket"), style: .plain, target: self, action: #selector(goingtoBasket))
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        //Delegete DataSource Register işlemleri Load ve ReloadData işlemlerinden Önceye Alındı
        
        let size = CGSize(width: 30.0, height: 30.0)
        self.startAnimating(size, message: "Yükleniyor", color: .orange, textColor: .white, fadeInAnimation: nil)
        
        
        productviewmodel.load { (succes) in
            self.tableView.reloadData()
            self.imageUrl = self.productviewmodel.image
            self.stopAnimating()
        }
    }
    
    
}

extension ProductViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productviewmodel.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = productviewmodel.productList[indexPath.row]
        let cell:ProductCell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
        cell.configure(product: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.choosenName = productviewmodel.Names[indexPath.row]
        self.choosenPrice = productviewmodel.prices[indexPath.row]
        self.choosenIndex = productviewmodel.ID[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.selectedProductNames = choosenName
            destinationVC.selectedProductPrice = choosenPrice
            destinationVC.choosenIndex = choosenIndex
            destinationVC.selectedImageUrl = imageUrl
        }
        if segue.identifier == "toBasketVC"{
            let destinationVC = segue.destination as! BasketViewController
            destinationVC.choosenNumber = choosenIndex
        }
    }
    
    
    @objc func goingtoBasket() {
        performSegue(withIdentifier: "toBasketVC", sender: self)
    }
    
    
    
}

