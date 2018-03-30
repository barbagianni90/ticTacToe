//
//  SignInViewController.swift
//  ticTacToeEx
//
//  Created by Stefano Apuzzo on 28/03/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "cherryTree")
//        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
//        self.view.insertSubview(backgroundImage, at: 0)
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        if self.emailTextField.text == "" || self.passTextField.text == "" {
            
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passTextField.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the HomeViewController if the login is sucessful
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    
                    let emailCurrentUser = Auth.auth().currentUser?.email as! String
                    
                    let ref = Database.database().reference()
                    
                    ref.child("Players").observeSingleEvent(of: .value, with:{ (snap) in
                        
                        let players = snap.value as! [String : Any]
                        
                        for(key, value) in players {
                            
                            let datiPlayer = value as! [String : Any]
                            
                            if datiPlayer["email"] as! String == emailCurrentUser {
                                MainViewController.user.nickName = key
                                MainViewController.user.vittorie = Int(datiPlayer["vittorie"] as! String)!
                                MainViewController.user.sconfitte = Int(datiPlayer["sconfitte"] as! String)!
                                MainViewController.user.stato = "online"
                            }
                        }
                        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                    })
                }
            }
        }
    }
}
