//
//  ViewController.swift
//  ETicApp
//
//  Created by Bilal Candemir on 18.11.2019.
//  Copyright © 2019 Bilal Candemir. All rights reserved.
//

import UIKit
import FirebaseAuth
import NVActivityIndicatorView
class ViewController: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButtondsign: UIButton!
    @IBOutlet weak var losePasswordButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func signInButton(_ sender: Any) {
        
        // if let olan bölüm silindi
        
        let size = CGSize(width: 30.0, height: 30.0)
        self.startAnimating(size, message: "Yükleniyor", color: .orange, textColor: .white, fadeInAnimation: nil)
        
        Auth.auth().signIn(withEmail: mailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil{
                self.stopAnimating()
                self.alert(mesaj: "Email Yanlış", title: "Hata")
            }
            else{
                self.segue(identifier: "PVController", control: true)
            }
        }
    }
    
    func segue(identifier:String, control:Bool){
        if(control){
            self.stopAnimating()
            performSegue(withIdentifier: identifier, sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mailTextField.textColor = Color.tintColor
        mailTextField.layer.shadowColor = UIColor.black.cgColor
        passwordTextField.textColor = Color.tintColor
        
        signInButtondsign.backgroundColor = Color.tintColor
        signInButtondsign.tintColor = Color.textColor
        signInButtondsign.layer.cornerRadius = 5
        losePasswordButton.backgroundColor = Color.tintColor
        losePasswordButton.tintColor = Color.textColor
        losePasswordButton.layer.cornerRadius = 5
        registerButton.backgroundColor = Color.tintColor
        registerButton.tintColor = Color.textColor
        registerButton.layer.cornerRadius = 5
        
        navigationItem.title = "Giriş Yap"
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            performSegue(withIdentifier: "PVController", sender: nil)
        }
    }
    
    @objc func alert( mesaj:String,title:String){
        let alert = UIAlertController(title: title, message: mesaj, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
    }


}

