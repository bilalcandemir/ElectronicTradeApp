//
//  NewUserViewController.swift
//  ETicApp
//
//  Created by Bilal Candemir on 19.11.2019.
//  Copyright © 2019 Bilal Candemir. All rights reserved.
//

import UIKit
import Firebase

class NewUserViewController: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var againpasswordTF: UITextField!
    @IBOutlet weak var createButton: UIButton!
    var message = ""
    var alertCounter = [String]()
    @IBAction func Create(_ sender: Any) {
        var ref:DatabaseReference
        ref = Database.database().reference().child("users")
        if passwordTF.text != againpasswordTF.text{
            addAlertMessage(mesaj: "Şifreler Uyuşmuyor")
        }
        
        if(passwordTF.text == ""){
            addAlertMessage(mesaj: "Lütfen Bir Şifre Giriniz")
        }
            
        if(nameTF.text == ""){
            addAlertMessage(mesaj: "Lütfen İsminizi Giriniz")
        }
        if(surnameTF.text == ""){
            addAlertMessage(mesaj: "Lütfen Soyadınızı Giriniz")
        }
        if(mailTF.text == ""){
            addAlertMessage(mesaj: "Lütfen Mail Adresinizi Giriniz")
        }
        
        
        if alertCounter.count != 0 {
            alertCounter.forEach { (counter) in
                self.message = counter + " " + self.message
                
            }
            alert(mesaj: self.message, title: "Hata")
            alertCounter.removeAll()
            self.message = ""
        }
        else{
            let userInfo = ["name" : nameTF.text!, "surname": surnameTF.text!]
            Auth.auth().createUser(withEmail: mailTF.text!, password: passwordTF.text!, completion: nil)
            ref.childByAutoId().setValue(userInfo)
            performSegue(withIdentifier: "toProductVC", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Kayıt Ol"
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func dissmissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func alert( mesaj:String,title:String){
        let alert = UIAlertController(title: title, message: mesaj, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func addAlertMessage(mesaj:String){
        self.alertCounter.append(mesaj + "\n")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
