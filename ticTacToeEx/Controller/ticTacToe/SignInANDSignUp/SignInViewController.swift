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
    
    
    
    
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var signinLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var passLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var registerLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        
        //set constraints home button
        
        homeButton.translatesAutoresizingMaskIntoConstraints = false
//        homeButton.layer.borderWidth = 0.5
//        homeButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: homeButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        NSLayoutConstraint(item: homeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 28).isActive = true
        NSLayoutConstraint(item: homeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        NSLayoutConstraint(item: homeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
  
        
        homeButton.setTitle("Home", for: .normal)
        homeButton.titleLabel?.font = UIFont(name: "raleway", size: UIScreen.main.bounds.height / 6)
        
        
        homeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        homeButton.titleLabel?.baselineAdjustment = .alignCenters
        
        
        // CONSTRAINTS SIGN IN LABEL
        
        signinLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        signinLabel.layer.borderWidth = 0.5
//        signinLabel.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: signinLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: signinLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 8).isActive = true
        
        NSLayoutConstraint(item: signinLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 2).isActive = true
        
        NSLayoutConstraint(item: signinLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 10).isActive = true
        
        
        // create text label
        
        let attTitleLabel = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.height / 12)]
        
        let signinLabelText = "Sign In"
        let attStr = NSMutableAttributedString(string: signinLabelText, attributes: attTitleLabel)
        signinLabel.attributedText = attStr
        
        signinLabel.adjustsFontSizeToFitWidth = true
        signinLabel.baselineAdjustment = .alignCenters

        
        
        
        // CONSTRAINTS EMAIL LABEL
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        emailLabel.layer.borderWidth = 0.5
//        emailLabel.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: emailLabel, attribute: .top, relatedBy: .equal, toItem: signinLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 18).isActive = true
        
          NSLayoutConstraint(item: emailLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
//        NSLayoutConstraint(item: emailLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.size.width / 15).isActive = true
        
        NSLayoutConstraint(item: emailLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 5).isActive = true
        
        NSLayoutConstraint(item: emailLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 20).isActive = true
        
        
        emailLabel.adjustsFontSizeToFitWidth = true
        emailLabel.baselineAdjustment = .alignCenters
        
        let emailLabelAttribute = [NSAttributedStringKey.font: UIFont(name: "Raleway-Light", size: UIScreen.main.bounds.height / 20)]
        let emailLabelText = "Email"
        let AttributeEmailLabel = NSMutableAttributedString(string: emailLabelText, attributes: emailLabelAttribute)
        emailLabel.attributedText = AttributeEmailLabel
        
        
        // CONTRAINTS EMAIL TEXTFIELD
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: emailTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
//        NSLayoutConstraint(item: emailTextField, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.size.width / 15).isActive = true
        
        NSLayoutConstraint(item: emailTextField, attribute: .top, relatedBy: .equal, toItem: emailLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 50).isActive = true
        
        NSLayoutConstraint(item: emailTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / (3/2)).isActive = true
        
        
        // CONSTRAINTS PASS LABEL
        
        passLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        passLabel.layer.borderWidth = 0.5
//        passLabel.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: passLabel, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 38).isActive = true
        
//        NSLayoutConstraint(item: passLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        
        NSLayoutConstraint(item: passLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: passLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 3).isActive = true
        
        NSLayoutConstraint(item: passLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 20).isActive = true
        
        
        passLabel.adjustsFontSizeToFitWidth = true
        passLabel.baselineAdjustment = .alignCenters
        
        
        let passLabelAttribute = [NSAttributedStringKey.font: UIFont(name: "Raleway-Light", size: passLabel.frame.width)]
        let passLabelText = "Password"
        let AttributePassLabel = NSMutableAttributedString(string: passLabelText, attributes: passLabelAttribute)
        passLabel.attributedText = AttributePassLabel
        
        
        // CONSTRAINTS PASS TEXTFIELD
        
        
        passTextField.translatesAutoresizingMaskIntoConstraints = false
//
        NSLayoutConstraint(item: passTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
//         NSLayoutConstraint(item: passTextField, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.size.width / 15).isActive = true
        
        NSLayoutConstraint(item: passTextField, attribute: .top, relatedBy: .equal, toItem: passLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 50).isActive = true
        
        NSLayoutConstraint(item: passTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / (3/2)).isActive = true
        
        
        
        
        // CONSTRAINTS REGISTER BUTTON
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
//        registerButton.layer.borderWidth = 0.5
//        registerButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: registerButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / -70).isActive = true
        
        NSLayoutConstraint(item: registerButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        
        NSLayoutConstraint(item: registerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 6).isActive = true
        
        NSLayoutConstraint(item: registerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 30 ).isActive = true
        
        registerButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        registerButton.titleLabel?.baselineAdjustment = .alignCenters
        
        registerButton.setTitle("Register!", for: .normal)
        registerButton.titleLabel?.font = UIFont(name: "Raleway-Light", size: UIScreen.main.bounds.height / 4)
        
        
        // CONSTRAINTS REGISTER LABEL
        
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        registerLabel.layer.borderWidth = 0.5
//        registerLabel.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: registerLabel, attribute: .bottom, relatedBy: .equal, toItem: registerButton, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / -200).isActive = true
        
        NSLayoutConstraint(item: registerLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: registerLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 2).isActive = true
        
        NSLayoutConstraint(item: registerLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 30).isActive = true
        
        registerLabel.adjustsFontSizeToFitWidth = true
        registerLabel.baselineAdjustment = .alignCenters
        
        let attrRegister = [NSAttributedStringKey.font: UIFont(name: "Raleway-Light", size: UIScreen.main.bounds.width / 2)]
        let registerLabelText = "Don't you have an account yet?"
        let attRegisterLabel = NSMutableAttributedString(string: registerLabelText, attributes: attrRegister)
        registerLabel.attributedText = attRegisterLabel
        
        
        
        // CONSTRAINTS BACKGROUND
        
//        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint(item: backgroundImage, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
//
//        NSLayoutConstraint(item: backgroundImage, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
//
//        NSLayoutConstraint(item: backgroundImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width).isActive = true
//
//        NSLayoutConstraint(item: backgroundImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute , multiplier: 1, constant: UIScreen.main.bounds.height).isActive = true
//
//        backgroundImage.image = UIImage(named: "start")
//        backgroundImage.contentMode = .scaleAspectFill
        
        
        
        //background
        let background: UIImageView!
        background = UIImageView(frame: view.frame)
        background.contentMode = .scaleAspectFill
        background.clipsToBounds = true
        background.image = UIImage(named: "start")
        background.center = view.center
        
        //blur effect
        let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
        blurEffect.frame = background.bounds
        background.addSubview(blurEffect)
        
        view.addSubview(background)
        view.sendSubview(toBack: background)
        
        // CONSTRAINTS LOGIN BUTTON
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
//        loginButton.layer.borderWidth = 0.5
//        loginButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: loginButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: passTextField, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 8).isActive = true
        
        NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 2).isActive = true
        
        NSLayoutConstraint(item: loginButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 6).isActive = true
        
        loginButton.titleLabel?.adjustsFontSizeToFitWidth = true
        loginButton.titleLabel?.baselineAdjustment = .alignCenters
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "raleway", size: UIScreen.main.bounds.width / 2)
        
        
        
        
        
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
        else if self.isValidEmail(testStr: ConvertOptionalString.convert(self.emailTextField.text!)) == false {
            
            let alertController = UIAlertController(title: "Error", message: "Please enter a valid email", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            
            let ref = Database.database().reference()
            
            ref.child("Players").child("\(MainViewController.user.id)").child("loggato").observeSingleEvent(of: .value, with: { (snap) in
                
                let value = snap.value as! String
                
                if value == "Si" {
                    
                    let alertController = UIAlertController(title: "Ops...", message: "Sei già connesso da un altro dispositivo", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
                else {
            
                    Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passTextField.text!) { (user, error) in
                
                    if error == nil {
                        
                        //Print into the console if successfully logged in
                        print("You have successfully logged in")
                        
                        let emailCurrentUser = ConvertOptionalString.convert(Auth.auth().currentUser?.email!)
                        
                        let ref = Database.database().reference()
                        
                        ref.child("Players").observeSingleEvent(of: .value, with:{ (snap) in
                            
                            let players = snap.value as! [String : Any]
                            
                            for(key, value) in players {
                                
                                let datiPlayer = value as! [String : Any]
                                
                                if datiPlayer["email"] as! String == emailCurrentUser {
                                    MainViewController.user.id = key
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
                                    ref.child("Players").child("\(MainViewController.user.id)").child("loggato").setValue("Si")
                                    
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
            })
        }
    }
    @IBAction func goHome(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.becomeFirstResponder()
    }
    
    
}
