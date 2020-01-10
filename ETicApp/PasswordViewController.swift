//
//  PasswordViewController.swift
//  ETicApp
//
//  Created by Bilal Candemir on 18.11.2019.
//  Copyright © 2019 Bilal Candemir. All rights reserved.
//

import UIKit
import FirebaseAuth
class PasswordViewController: UIViewController {
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBAction func Reset(_ sender: Any) {
       // if let kısım silindi
        Auth.auth().sendPasswordReset(withEmail: mailTextField.text!) { (error) in
            if error != nil{
                self.alert(title: "Hata!", message: "Lütfen Geçerli Bir Mail Adresi Giriniz!")
            }
            else{
                
                self.performSegue(withIdentifier: "toLogInPage", sender: nil)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Şifremi Unuttum"
        // Do any additional setup after loading the view.
    }
    

    func alert(title:String ,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
        
    }

}
