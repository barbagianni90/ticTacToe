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
import Alamofire


class SignUpViewController: UIViewController{
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    static var imageProfileSelected: UIImage!
    var nicknameChose = ""
    
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
        
        self.activityIndicator.center = CGPoint(x: self.view.center.x, y: UIScreen.main.bounds.height / 8)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        self.view.addSubview(self.activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        if emailTextField.text == "" || passTextField.text == "" {
            
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        else if self.isValidEmail(testStr: ConvertOptionalString.convert(self.emailTextField.text)) == false {
            
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            let alertController = UIAlertController(title: "Error", message: "Please enter a valid email", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            
            if (NetworkReachabilityManager()?.isReachable)! {
            
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passTextField.text!) { (user, error) in
                    
                    if error == nil {
                        
                        self.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        
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
                                self.nicknameChose = name
                                MainViewController.user.stato = "online"
                                MainViewController.user.email = "\(ConvertOptionalString.convert(self.emailTextField.text))"
                                
                                let ref = Database.database().reference()
                                
                                ref.child("Players").child("\(MainViewController.user.id)").setValue(
                                    [   "nickname" : "\(name)",
                                        "email" : "\(ConvertOptionalString.convert(self.emailTextField.text))",
                                        "stato" : "online",
                                        "vittorieTris" : "0",
                                        "vittorieDama" : "0",
                                        "sconfitteTris" : "0",
                                        "sconfitteDama" : "0",
                                        "invitatoDa" : "",
                                        "invitoAccettato" : "",
                                        "loggato" : "Si" ])
                                
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
                            
                            self.getData()
                            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                            
                        }))
                        
                        self.present(alert, animated: true)
                        
                    } else {
                        
                        self.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
            else {
                
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                let alertController = UIAlertController(title: "Connessione assente", message: nil, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
            }
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
        
        
        
        // HOME BUTTON
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        //        homeButton.layer.borderWidth = 0.5
        //        homeButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: homeButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        NSLayoutConstraint(item: homeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 28).isActive = true
        NSLayoutConstraint(item: homeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        NSLayoutConstraint(item: homeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        
        homeButton.setTitle("Home", for: .normal)
        homeButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: UIScreen.main.bounds.height / 6)
        
        
        homeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        homeButton.titleLabel?.baselineAdjustment = .alignCenters
        
        
        
        // SIGN UP LABEL
        
        signupLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //        signinLabel.layer.borderWidth = 0.5
        //        signinLabel.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: signupLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: signupLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 8).isActive = true
        
        NSLayoutConstraint(item: signupLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 2).isActive = true
        
        NSLayoutConstraint(item: signupLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 10).isActive = true
        
   
        let attTitleLabel = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.height / 12)]
        let signupLabelText = "Sign Up"
        let attStr = NSMutableAttributedString(string: signupLabelText, attributes: attTitleLabel)
        signupLabel.attributedText = attStr
        
        signupLabel.adjustsFontSizeToFitWidth = true
        
        signupLabel.baselineAdjustment = .alignCenters
        signupLabel.textAlignment = .center
        
        
        
        // EMAIL LABEL
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
//                emailLabel.layer.borderWidth = 0.5
//                emailLabel.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: emailLabel, attribute: .top, relatedBy: .equal, toItem: signupLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 20).isActive = true
        
        
//        NSLayoutConstraint(item: emailLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        
        NSLayoutConstraint(item: emailLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        
        
        NSLayoutConstraint(item: emailLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 6).isActive = true
        
        NSLayoutConstraint(item: emailLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 26).isActive = true
        
        
        
        
        let emailLabelAttribute = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.width / 5)]
        let emailLabelText = "Email"
        let AttributeEmailLabel = NSMutableAttributedString(string: emailLabelText, attributes: emailLabelAttribute)
        emailLabel.attributedText = AttributeEmailLabel
        
        emailLabel.adjustsFontSizeToFitWidth = true
        emailLabel.baselineAdjustment = .alignCenters
        
        
        //  EMAIL TEXTFIELD
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: emailTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: emailTextField, attribute: .top, relatedBy: .equal, toItem: emailLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 80).isActive = true
        
        NSLayoutConstraint(item: emailTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / (3/2)).isActive = true
        
        
        
        // CONSTRAINTS PASS LABEL
        
        passLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //        passLabel.layer.borderWidth = 0.5
        //        passLabel.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: passLabel, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 20).isActive = true
        
        
        NSLayoutConstraint(item: passLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        
//        NSLayoutConstraint(item: passLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        
        NSLayoutConstraint(item: passLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 3).isActive = true
        
        NSLayoutConstraint(item: passLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 20).isActive = true
        
        
        passLabel.adjustsFontSizeToFitWidth = true
        passLabel.baselineAdjustment = .alignCenters
        
        
        let passLabelAttribute = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.width / 3)]
        let passLabelText = "Password"
        let AttributePassLabel = NSMutableAttributedString(string: passLabelText, attributes: passLabelAttribute)
        passLabel.attributedText = AttributePassLabel
        
        
        // CONSTRAINTS PASS TEXTFIELD
        
        
        passTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: passTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: passTextField, attribute: .top, relatedBy: .equal, toItem: passLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 80).isActive = true
        
        NSLayoutConstraint(item: passTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / (3/2)).isActive = true
        
        
        
        
        // CONSTRAINTS AVATAR LABEL
        
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint(item: avatarLabel, attribute: .top, relatedBy: .equal, toItem: passTextField, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 38).isActive = true
        
        
        NSLayoutConstraint(item: avatarLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        
//        NSLayoutConstraint(item: avatarLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        
        NSLayoutConstraint(item: avatarLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 5).isActive = true
        
        NSLayoutConstraint(item: avatarLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 20).isActive = true
        
        
        avatarLabel.adjustsFontSizeToFitWidth = true
        avatarLabel.baselineAdjustment = .alignCenters
        
        
        let avatarLabelAttribute = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.width / 5)]
        let avatarLabelText = "Avatar"
        let AttributeAvatarLabel = NSMutableAttributedString(string: avatarLabelText, attributes: avatarLabelAttribute)
        avatarLabel.attributedText = AttributeAvatarLabel
        
        
        
        // CONSTRAINTS STACK VIEW
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: avatarLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 40).isActive = true
        
        NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 1.5).isActive = true
        
        NSLayoutConstraint(item: stackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 11).isActive = true
        
        
        stackView.distribution = .fillEqually
        stackView.contentMode = .scaleAspectFill
        
        
        
        // CAMERA BUTTON
        
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        
//        cameraButton.layer.borderColor = UIColor.black.cgColor
//        cameraButton.layer.borderWidth = 0.5
        
        NSLayoutConstraint(item: cameraButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: cameraButton, attribute: .top, relatedBy: .equal, toItem: stackView, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 50).isActive = true
        
        NSLayoutConstraint(item: cameraButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 5).isActive = true
        
        NSLayoutConstraint(item: cameraButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 12).isActive = true
        
        cameraButton.setImage(UIImage(named: "camera"), for: .normal)
        
        cameraButton.contentMode = .scaleAspectFill
        
        
        
        
        // sign in button
        
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: signinButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: signinButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / -70).isActive = true
        
        NSLayoutConstraint(item: signinButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 6).isActive = true
        
        NSLayoutConstraint(item: signinButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 30 ).isActive = true
        
        
        signinButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        signinButton.titleLabel?.baselineAdjustment = .alignCenters
        
        signinButton.setTitle("Sign in!", for: .normal)
        signinButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: UIScreen.main.bounds.height / 4)
        
        
        
        // sign in label
        
        
        signinLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint(item: signinLabel, attribute: .bottom, relatedBy: .equal, toItem: signinButton, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / -200).isActive = true
        
        NSLayoutConstraint(item: signinLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: signinLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 2).isActive = true
        
        NSLayoutConstraint(item: signinLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 30).isActive = true
        
        signinLabel.adjustsFontSizeToFitWidth = true
        signinLabel.baselineAdjustment = .alignCenters
        
        let attrSignin = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.width / 2)]
        let signinLabelText = "Do you already have an account?"
        let attSigninLabel = NSMutableAttributedString(string: signinLabelText, attributes: attrSignin)
        signinLabel.attributedText = attSigninLabel
        
        
        
        
        // SUBMIT
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
//        submitButton.layer.borderWidth = 0.5
//        submitButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: submitButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: submitButton, attribute: .top, relatedBy: .equal, toItem: cameraButton, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 50).isActive = true
        
        NSLayoutConstraint(item: submitButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 3).isActive = true
        
        NSLayoutConstraint(item: submitButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 10).isActive = true
        
        submitButton.setTitle( "Submit", for: .normal)
        
        submitButton.titleLabel?.adjustsFontSizeToFitWidth = true
        submitButton.titleLabel?.baselineAdjustment = .alignCenters
        
        submitButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: UIScreen.main.bounds.height / 12)
        
        
        
        
        
        
        
        
    }
    @IBAction func avatarSelected(_ sender: UIButton) {
        
        SignUpViewController.imageProfileSelected = sender.imageView?.image
    }
    @IBAction func goHome(_ sender: Any) {
        
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func getData() {
        
        let url = URL(string: "http://10.0.101.6:8081/api/jsonws/add-user-portlet.appuser/get-users")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            let jsonObj: Array<[String : Any]> = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Array<[String : Any]>
            
            var newUser = true
            
            for obj in jsonObj {
                
                if  ConvertOptionalString.convert(obj["password"]!) == ConvertOptionalString.convert(self.passTextField.text!) && ConvertOptionalString.convert(obj["email"]!) == ConvertOptionalString.convert(self.emailTextField.text!) {
                    
                    if obj["confirm"] as! Int == 0  {
                        
                        newUser = false
                        self.postCompleteUser(ConvertOptionalString.convert(self.emailTextField.text!))
                    }
                }
            }
            if newUser == true {
                
                self.postNewUser(self.nicknameChose, ConvertOptionalString.convert(self.emailTextField.text!), ConvertOptionalString.convert(self.passTextField.text!))
            }
            
        }.resume()
    }
    func postCompleteUser(_ email: String) {
        
        let url = URL(string: "http://10.0.101.6:8081/api/jsonws/add-user-portlet.appuser/conf-user/-email")
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append((email.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "email")
            
        }, to: url!,
           
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseData { response in
                    debugPrint(response)
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
    func postNewUser(_ nickname: String, _ email: String, _ password: String) {
        
        let url = URL(string: "http://10.0.101.6:8081/api/jsonws/add-user-portlet.appuser/add-app-user/-tag/-email/-password")
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append((nickname.data(using: .utf8))!, withName: "tag")
            multipartFormData.append((email.data(using: .utf8))!, withName: "email")
            multipartFormData.append((password.data(using: .utf8))!, withName: "password")
            
        }, to: url!,
           
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseData { response in
                    debugPrint(response)
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
    }
}
