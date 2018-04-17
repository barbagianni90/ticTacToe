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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if MainViewController.user.nickName == ""{
            label.text = "Sign In"
        }else{
            label.text = "Log out"
        }
        label.adjustsFontForContentSizeCategory = true
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
            }
        }else if indexPath.row == 1{
            if MainViewController.user.nickName == ""{
                let signInView = UIStoryboard(name: "SignInANDSignUp", bundle: nil).instantiateViewController(withIdentifier: "signIn")
                self.present(signInView, animated: true, completion: nil)
            }else{
                do {
                    try Auth.auth().signOut()
                    MainViewController.user = User()
                    label.text = "Sign In"
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