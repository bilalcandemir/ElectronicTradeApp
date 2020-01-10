//
//  ProductCell.swift
//  ETicApp
//
//  Created by Bilal Candemir on 20.11.2019.
//  Copyright © 2019 Bilal Candemir. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    
    func configure( product: Proudcts){
        name.text = product.pName
        price.text = String(product.pPrice)
        
        accessoryType = .none
        selectionStyle = .none
    }
    
  
    
}

