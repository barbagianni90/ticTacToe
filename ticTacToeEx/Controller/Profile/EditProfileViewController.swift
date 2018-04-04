//
//  EditProfileViewController.swift
//  ticTacToeEx
//
//  Created by Mac Luca on 30/03/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit
import Firebase

class EditProfileViewController: UIViewController {
    
    var avatarSelected = ""

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var nickNameTextField: UITextField!
    
    @IBOutlet var avatars: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.hideKeyboardWhenTappedAround()
        
        var i = 1
        for button in avatars {
            button.setImage(UIImage(named: "avatar\(i).png"), for: .normal)
            button.setTitle("avatar\(i).png", for: .normal)
            i += 1
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func avatarSelected(_ sender: UIButton) {
        
        self.avatarSelected = sender.titleLabel?.text as! String
        MainViewController.user.image = sender.imageView?.image
    }
    
    @IBAction func done(_ sender: Any) {
        
        if emailTextField.text == "" && passTextField.text == "" && self.avatarSelected == "" {
            let alertController = UIAlertController(title: "Error", message: "Nessuna modifica effettuata", preferredStyle: .alert)
            
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
            
            let alert = UIAlertController(title: "Confermare le modifiche?", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                let ref = Database.database().reference()
                
                if self.nickNameTextField.text != "" {
                    
                    ref.child("Players").child("\(MainViewController.user.nickName)").removeValue()
                    ref.child("Players").child("\(self.nickNameTextField.text as! String)").setValue(["email" : "\(MainViewController.user.email)",
                        "stato" : "online",
                        "vittorie" : "\(MainViewController.user.vittorie as! String)",
                        "sconfitte" : "\(MainViewController.user.vittorie as! String)",
                        "invitatoDa" : "",
                        "invitoAccettato" : "",
                        "avatar": "\(MainViewController.user.nameImage)"])
                    
                    MainViewController.user.nickName = self.nickNameTextField.text as! String
                    MainViewController.user.stato = "online"
                    
                    
                }
                if self.emailTextField.text != "" {
                    
                    Auth.auth().currentUser?.updateEmail(to: "\(self.emailTextField.text as! String)", completion: nil)
                }
                
                if self.passTextField.text != "" {
                    
                    Auth.auth().currentUser?.updatePassword(to: "\(self.passTextField.text as! String)", completion: nil)
                }
                
                if self.avatarSelected != "" {
                    
                    MainViewController.user.nameImage = self.avatarSelected
                    MainViewController.user.image = UIImage(named: "\(self.avatarSelected)")
                }
                
                
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                
            }))
            
            self.present(alert, animated: true)
        }
    }
    
}
