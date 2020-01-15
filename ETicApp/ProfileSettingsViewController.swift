//
//  ProfileSettingsViewController.swift
//  ETicApp
//
//  Created by Bilal Candemir on 5.12.2019.
//  Copyright © 2019 Bilal Candemir. All rights reserved.
//

import UIKit
import Firebase
class ProfileSettingsViewController: UIViewController {
    @IBAction func LogOutButton(_ sender: Any) {
        do{
            try
                Auth.auth().signOut()
        }catch{
            print("Error")
        }
        performSegue(withIdentifier: "toSignInVC", sender: nil)
    }
    @IBOutlet weak var logOutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Kullanıcı Ayarları"
        logOutButton.tintColor = Color.textColor
        logOutButton.backgroundColor = Color.tintColor
        logOutButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
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
