//
//  SignUpViewController.swift
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

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    
    @IBAction func signInButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        
        if emailTextField.text == "" || passTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
            
        else {
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passTextField.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully signed up")
                    
                    let alert = UIAlertController(title: "Insert your nickname", message: nil, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    
                    alert.addTextField(configurationHandler: { textField in
                        textField.placeholder = "Input your nickname here..."
                    })
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        
                        if let name = alert.textFields?.first?.text {
                            
                            MainViewController.user.nickName = name
                            MainViewController.user.stato = "online"
                            
                            let ref = Database.database().reference()
                            
                            ref.child("Players").child("\(MainViewController.user.nickName)").setValue(
                                ["password" : "\(self.passTextField.text as! String)",
                                    "stato" : "online",
                                    "vittorie" : "0",
                                    "sconfitte" : "0",
                                    "invitatoDa" : "",
                                    "invitoAccettato" : ""])
                        }
                        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                        
                    }))
                    
                    self.present(alert, animated: true)
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
        //dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        //        backgroundImage.image = UIImage(named: "cherryTree")
        //        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        //        self.view.insertSubview(backgroundImage, at: 0)
    }
}

