//
//  StartTableViewController.swift
//  ticTacToeEx
//
//  Created by CertimeterGroup on 16/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit
import Firebase

class StartTableViewController: UITableViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var profileLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if MainViewController.user.nickName == ""{
            
            label.text = "Sign In"
            
        }
        else{
            
            label.text = "Log out"
        }
        
        
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        
        
//        label.layer.borderWidth = 0.5
//        label.layer.borderColor = UIColor(displayP3Red: 243/255.0, green: 223/255.0, blue: 76/255.0, alpha: 1).cgColor
        
        
//        profileLabel.layer.borderWidth = 0.5
//        profileLabel.layer.borderColor = UIColor(displayP3Red: 243/255.0, green: 223/255.0, blue: 76/255.0, alpha: 1).cgColor
        
        
        tableView.backgroundColor = UIColor.clear
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if MainViewController.user.nickName == ""{
            
            label.text = "Sign In"
        }else{
            
            label.text = "Log out"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if MainViewController.user.nickName == ""{
                let alertController = UIAlertController(title: "Ops...", message: "Devi prima accedere al tuo profilo", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                present(alertController, animated: true, completion: nil)
                print("Connettiti")
            }else{
                let profile = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "profileInfo")
                self.present(profile,animated: true,completion: nil)
                
                StartingViewController.first = true
            }
        }else if indexPath.row == 1{
            if MainViewController.user.nickName == ""{
                let signInView = UIStoryboard(name: "SignInANDSignUp", bundle: nil).instantiateViewController(withIdentifier: "signIn")
                self.present(signInView, animated: true, completion: nil)
            }else{
                do {
                    try Auth.auth().signOut()
                    let ref = Database.database().reference()
                    ref.child("Players").child("\(MainViewController.user.id)").child("loggato").setValue("No")
                    MainViewController.user = User()
                    label.text = "Sign In"
                    NotificationCenter.default.post(name: Notification.Name(rawValue:"LogOut"), object: nil)
                    print("Utente disconnesso\n")
                    
                    
                }
                catch {
                    print("Error Log out")
                }
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 12
    }
    
    
}
