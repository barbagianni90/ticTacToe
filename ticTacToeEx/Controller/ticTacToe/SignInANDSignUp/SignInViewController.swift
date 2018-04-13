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
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
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
        
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "cherryTree")
//        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
//        self.view.insertSubview(backgroundImage, at: 0)
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(self.activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        if self.emailTextField.text == "" || self.passTextField.text == "" {
            
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else if self.isValidEmail(testStr: self.emailTextField.text as! String) == false {
            
            let alertController = UIAlertController(title: "Error", message: "Please enter a valid email", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passTextField.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    let emailCurrentUser = Auth.auth().currentUser?.email as! String
                    
                    let ref = Database.database().reference()
                    
                    ref.child("Players").observeSingleEvent(of: .value, with:{ (snap) in
                        
                        let players = snap.value as! [String : Any]
                        
                        for(key, value) in players {
                            
                            let datiPlayer = value as! [String : Any]
                            
                            if datiPlayer["email"] as! String == emailCurrentUser {
                                MainViewController.user.nickName = datiPlayer["nickname"] as! String
                                MainViewController.user.email = datiPlayer["email"] as! String
                                MainViewController.user.vittorie = Int(datiPlayer["vittorie"] as! String)!
                                MainViewController.user.sconfitte = Int(datiPlayer["sconfitte"] as! String)!
                                MainViewController.user.stato = "online"
                                
                                let decodeString = Data(base64Encoded: datiPlayer["image"] as! String)
                                
                                let image = UIImage(data: decodeString!)
                                
                                let imagePNG = UIImagePNGRepresentation(image!)
                                
                                MainViewController.user.image = UIImage(data: imagePNG!)
                                
                                ref.child("Players").child("\(MainViewController.user.id)").child("stato").setValue("online")
                                
                                self.activityIndicator.stopAnimating()
                                UIApplication.shared.endIgnoringInteractionEvents()
                                
                                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                                
                            }
                        }
                    })
                    
                } else {
                    
                    print("wrong login")
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
            }
        }
    }
    @IBAction func goHome(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
