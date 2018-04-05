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
import FirebaseStorage


class SignUpViewController: UIViewController {
    
    static var imageProfileSelected: UIImage!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    
    @IBOutlet var avatars: [UIButton]!
    
    @IBOutlet weak var scatta: UIButton!
    
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
        else if self.isValidEmail(testStr: self.emailTextField.text as! String) == false {
            
            let alertController = UIAlertController(title: "Error", message: "Please enter a valid email", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
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
                            MainViewController.user.email = "\(self.emailTextField.text as! String)"
                            
                            let ref = Database.database().reference()
                            
                            ref.child("Players").child("\(MainViewController.user.nickName)").setValue(
                                ["email" : "\(self.emailTextField.text as! String)",
                                    "stato" : "online",
                                    "vittorie" : "0",
                                    "sconfitte" : "0",
                                    "invitatoDa" : "",
                                    "invitoAccettato" : ""])
                            
                            
                        }
                        
                        let sRef = Storage.storage().reference()
                        
                        let uploadData = UIImagePNGRepresentation(SignUpViewController.imageProfileSelected)
                        
                        sRef.child("Images").child("\(MainViewController.user.nickName)").child("myImage.png").putData(uploadData!)
                        
                        MainViewController.user.image = SignUpViewController.imageProfileSelected
                        
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
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        var i = 1
        for button in avatars {
            button.setImage(UIImage(named: "avatar\(i).png"), for: .normal)
            button.setTitle("avatar\(i).png", for: .normal)
            i += 1
        }
        
        self.scatta.layer.cornerRadius = self.scatta.frame.size.width / 2
        
    }
    @IBAction func avatarSelected(_ sender: UIButton) {
        
        SignUpViewController.imageProfileSelected = sender.imageView?.image
    }
}

