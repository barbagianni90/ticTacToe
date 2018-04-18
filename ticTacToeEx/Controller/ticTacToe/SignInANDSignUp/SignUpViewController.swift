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


class SignUpViewController: UIViewController, URLSessionDataDelegate{
    
    let url = "http://10.0.101.6:8081/api/jsonws/add-user-portlet.appuser/get-users"
    
    static var imageProfileSelected: UIImage!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var signupLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var passLabel: UILabel!
    
    @IBOutlet weak var avatarLabel: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    
    @IBOutlet weak var signinLabel: UILabel!
    
    @IBOutlet var avatars: [UIButton]!
    
    @IBOutlet weak var scatta: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
    
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
                            
                            MainViewController.user.id = (user?.uid)!
                            MainViewController.user.nickName = name
                            MainViewController.user.stato = "online"
                            MainViewController.user.email = "\(self.emailTextField.text as! String)"
                            
                            let ref = Database.database().reference()
                            
                            ref.child("Players").child("\(MainViewController.user.id)").setValue(
                                [   "nickname" : "\(name)",
                                    "email" : "\(self.emailTextField.text as! String)",
                                    "stato" : "online",
                                    "vittorie" : "0",
                                    "sconfitte" : "0",
                                    "invitatoDa" : "",
                                    "invitoAccettato" : ""  ])
                            
                            if SignUpViewController.imageProfileSelected != nil {
                                
                                let uploadData = UIImagePNGRepresentation(self.resizeImage(image: SignUpViewController.imageProfileSelected))!
                                
                                let base64ImageString = uploadData.base64EncodedString()
                                
                                ref.child("Players").child("\(MainViewController.user.id)").child("image").setValue(base64ImageString)
                                
                                MainViewController.user.image = SignUpViewController.imageProfileSelected
                            }
                                
                            else {
                                
                                let uploadData = UIImagePNGRepresentation(self.resizeImage(image:UIImage(named: "default.jpg")!))!
                                
                                let base64ImageString = uploadData.base64EncodedString()
                                
                                ref.child("Players").child("\(MainViewController.user.id)").child("image").setValue(base64ImageString)
                                
                                MainViewController.user.image = UIImage(named: "default.jpg")
                            }
                            
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
            
            let URLSessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: URLSessionConfig, delegate: self, delegateQueue: OperationQueue.main)
            session.dataTask(with: URL(string: self.url)!)
            
        }
    }
    
    func resizeImage(image: UIImage) -> UIImage {
        
        var actualHeight:Float = Float(image.size.height)
        var actualWidth:Float = Float(image.size.width)
        
        let maxHeight:Float = 200.0 //your choose height
        let maxWidth:Float = 200.0  //your choose width
        
        var imgRatio:Float = actualWidth/actualHeight
        let maxRatio:Float = maxWidth/maxHeight
        
        if (actualHeight > maxHeight) || (actualWidth > maxWidth)
        {
            if(imgRatio < maxRatio)
            {
                imgRatio = maxHeight / actualHeight;
                actualWidth = imgRatio * actualWidth;
                actualHeight = maxHeight;
            }
            else if(imgRatio > maxRatio)
            {
                imgRatio = maxWidth / actualWidth;
                actualHeight = imgRatio * actualHeight;
                actualWidth = maxWidth;
            }
            else
            {
                actualHeight = maxHeight;
                actualWidth = maxWidth;
            }
        }
        
        let rect: CGRect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        let imageData:NSData = UIImageJPEGRepresentation(img, 1.0)! as NSData
        UIGraphicsEndImageContext()
        
        return UIImage(data: imageData as Data)!
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
        
        
        // CONSTRAINTS
        
        
        
        // BACKGROUND
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: backgroundImage, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: backgroundImage, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: backgroundImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width).isActive = true
        
        NSLayoutConstraint(item: backgroundImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute , multiplier: 1, constant: UIScreen.main.bounds.height).isActive = true
        
        backgroundImage.image = UIImage(named: "cherryTree")
        backgroundImage.contentMode = .scaleAspectFill
        
        
        
        // HOME BUTTON
        
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        //        homeButton.layer.borderWidth = 0.5
        //        homeButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: homeButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        
        NSLayoutConstraint(item: homeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 28).isActive = true
        
        NSLayoutConstraint(item: homeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        NSLayoutConstraint(item: homeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        homeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        homeButton.titleLabel?.baselineAdjustment = .alignCenters
        
        homeButton.setTitle("Home", for: .normal)
        homeButton.titleLabel?.font = UIFont(name: "shojumaru", size: homeButton.frame.width)
        
        
        
        // SIGN UP LABEL
        
        signupLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //        signinLabel.layer.borderWidth = 0.5
        //        signinLabel.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: signupLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: signupLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 10).isActive = true
        
        NSLayoutConstraint(item: signupLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 2).isActive = true
        
        NSLayoutConstraint(item: signupLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 10).isActive = true
        
   
        let attTitleLabel = [NSAttributedStringKey.font: UIFont(name: "shojumaru", size: signupLabel.frame.width)]
        let signupLabelText = "Sign Up"
        let attStr = NSMutableAttributedString(string: signupLabelText, attributes: attTitleLabel)
        signupLabel.attributedText = attStr
        
        signupLabel.adjustsFontSizeToFitWidth = true
        
        signupLabel.baselineAdjustment = .alignCenters
        
        
        
        // EMAIL LABEL
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
//                emailLabel.layer.borderWidth = 0.5
//                emailLabel.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: emailLabel, attribute: .top, relatedBy: .equal, toItem: signupLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 30).isActive = true
        
        
        NSLayoutConstraint(item: emailLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        
        NSLayoutConstraint(item: emailLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 5).isActive = true
        
        NSLayoutConstraint(item: emailLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 26).isActive = true
        
        
        
        
        let emailLabelAttribute = [NSAttributedStringKey.font: UIFont(name: "catCafe", size: 40)]
        let emailLabelText = "Email:"
        let AttributeEmailLabel = NSMutableAttributedString(string: emailLabelText, attributes: emailLabelAttribute)
        emailLabel.attributedText = AttributeEmailLabel
        
        emailLabel.adjustsFontSizeToFitWidth = true
        emailLabel.baselineAdjustment = .alignCenters
        
        
        //  EMAIL TEXTFIELD
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: emailTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: emailTextField, attribute: .top, relatedBy: .equal, toItem: emailLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 120).isActive = true
        
        NSLayoutConstraint(item: emailTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width - 40).isActive = true
        
        
        
        // CONSTRAINTS PASS LABEL
        
        passLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //        passLabel.layer.borderWidth = 0.5
        //        passLabel.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: passLabel, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 38).isActive = true
        
        NSLayoutConstraint(item: passLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        
        NSLayoutConstraint(item: passLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 3).isActive = true
        
        NSLayoutConstraint(item: passLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 20).isActive = true
        
        
        passLabel.adjustsFontSizeToFitWidth = true
        passLabel.baselineAdjustment = .alignCenters
        
        
        let passLabelAttribute = [NSAttributedStringKey.font: UIFont(name: "catCafe", size: passLabel.frame.width)]
        let passLabelText = "Password:"
        let AttributePassLabel = NSMutableAttributedString(string: passLabelText, attributes: passLabelAttribute)
        passLabel.attributedText = AttributePassLabel
        
        
        // CONSTRAINTS PASS TEXTFIELD
        
        
        passTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: passTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: passTextField, attribute: .top, relatedBy: .equal, toItem: passLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 120).isActive = true
        
        NSLayoutConstraint(item: passTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width - 40).isActive = true
        
        
        
        
        // CONSTRAINTS AVATAR LABEL
        
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint(item: avatarLabel, attribute: .top, relatedBy: .equal, toItem: passTextField, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 38).isActive = true
        
        NSLayoutConstraint(item: avatarLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        
        NSLayoutConstraint(item: avatarLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 5).isActive = true
        
        NSLayoutConstraint(item: avatarLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 20).isActive = true
        
        
        avatarLabel.adjustsFontSizeToFitWidth = true
        avatarLabel.baselineAdjustment = .alignCenters
        
        
        let avatarLabelAttribute = [NSAttributedStringKey.font: UIFont(name: "catCafe", size: avatarLabel.frame.width)]
        let avatarLabelText = "Avatar:"
        let AttributeAvatarLabel = NSMutableAttributedString(string: avatarLabelText, attributes: avatarLabelAttribute)
        avatarLabel.attributedText = AttributeAvatarLabel
        
        
        
        // CONSTRAINTS STACK VIEW
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: avatarLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 120).isActive = true
        
        NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width - 40).isActive = true
        
        NSLayoutConstraint(item: stackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 17).isActive = true
        
        
        stackView.distribution = .fillEqually
        stackView.contentMode = .scaleAspectFill
        
        
        
        // CAMERA BUTTON
        
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: cameraButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: cameraButton, attribute: .top, relatedBy: .equal, toItem: stackView, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 30).isActive = true
        
        NSLayoutConstraint(item: cameraButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 8).isActive = true
        
        NSLayoutConstraint(item: cameraButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 8).isActive = true
        
        cameraButton.setImage(UIImage(named: "camera.png"), for: .normal)
        
        
        
        
        // sign in button
        
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: signinButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: signinButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / -70).isActive = true
        
        NSLayoutConstraint(item: signinButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 4).isActive = true
        
        NSLayoutConstraint(item: signinButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 30 ).isActive = true
        
        
        signinButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        signinButton.titleLabel?.baselineAdjustment = .alignCenters
        
        signinButton.setTitle("Sign in!", for: .normal)
        signinButton.titleLabel?.font = UIFont(name: "catCafe", size: signinButton.frame.width)
        
        
        
        // sign in label
        
        
        signinLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint(item: signinLabel, attribute: .bottom, relatedBy: .equal, toItem: signinButton, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / -200).isActive = true
        
        NSLayoutConstraint(item: signinLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: signinLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 2).isActive = true
        
        NSLayoutConstraint(item: signinLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 30).isActive = true
        
        signinLabel.adjustsFontSizeToFitWidth = true
        signinLabel.baselineAdjustment = .alignCenters
        
        let attrSignin = [NSAttributedStringKey.font: UIFont(name: "catCafe", size: 17)]
        let signinLabelText = "Don't you have an account yet?"
        let attSigninLabel = NSMutableAttributedString(string: signinLabelText, attributes: attrSignin)
        signinLabel.attributedText = attSigninLabel
        
        
        
        
        // SUBMIT
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
//        submitButton.layer.borderWidth = 0.5
//        submitButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: submitButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: submitButton, attribute: .top, relatedBy: .equal, toItem: cameraButton, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 120).isActive = true
        
        NSLayoutConstraint(item: submitButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 2).isActive = true
        
        NSLayoutConstraint(item: submitButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 6).isActive = true
        
        submitButton.setTitle( "Submit", for: .normal)
        
        submitButton.titleLabel?.adjustsFontSizeToFitWidth = true
        submitButton.titleLabel?.baselineAdjustment = .alignCenters
        
        submitButton.titleLabel?.font = UIFont(name: "shojumaru", size: submitButton.frame.width)
        
        
        
        
        
        
        
        
    }
    @IBAction func avatarSelected(_ sender: UIButton) {
        
        SignUpViewController.imageProfileSelected = sender.imageView?.image
    }
    @IBAction func goHome(_ sender: Any) {
        
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        let jsonObj: Array<[String : Any]> = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Array<[String : Any]>
        
        for obj in jsonObj {
            
             if obj["password"] as! String == self.passTextField.text as! String && obj["email"] as! String == self.emailTextField.text as! String {
                
                if obj["confirm"] as! Int == 0  {
                    
                    
                }
            }
        }
    }
}

