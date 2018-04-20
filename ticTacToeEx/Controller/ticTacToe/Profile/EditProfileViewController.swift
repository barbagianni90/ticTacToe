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
    
    static var imageSelected: UIImage!
    
    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var editLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var passLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var avatarLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var nickNameTextField: UITextField!
    
    @IBOutlet var avatars: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        var i = 1
        for button in avatars {
            button.setImage(UIImage(named: "avatar\(i).png"), for: .normal)
            button.setTitle("avatar\(i).png", for: .normal)
            i += 1
        }

        
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
        
        
        
        
        // PROFILE BUTTON
        
        
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        
//        homeButton.layer.borderWidth = 0.5
//        homeButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: profileButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        
        NSLayoutConstraint(item: profileButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 15).isActive = true
        
        NSLayoutConstraint(item: profileButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        NSLayoutConstraint(item: profileButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        
        profileButton.setTitle("Back", for: .normal)
        profileButton.titleLabel?.font = UIFont(name: "raleway", size: UIScreen.main.bounds.height / 6)
        profileButton.setTitleColor(UIColor.white, for: .normal)
        
        profileButton.titleLabel?.adjustsFontSizeToFitWidth = true
        profileButton.titleLabel?.baselineAdjustment = .alignCenters
        
        // DONE BUTTON
        
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
//        doneButton.layer.borderWidth = 0.5
//        doneButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: doneButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: UIScreen.main.bounds.width / -15).isActive = true
        
        NSLayoutConstraint(item: doneButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 15).isActive = true
        
        NSLayoutConstraint(item: doneButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        NSLayoutConstraint(item: doneButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.font = UIFont(name: "raleway", size: UIScreen.main.bounds.height / 6)
        
        
        doneButton.titleLabel?.adjustsFontSizeToFitWidth = true
        doneButton.titleLabel?.baselineAdjustment = .alignCenters
        doneButton.titleLabel?.textAlignment = .right
        
        
   
        
        
        // Edit profile LABEL
        
        editLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: editLabel, attribute: .top, relatedBy: .equal, toItem: doneButton, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 10).isActive = true
        
        NSLayoutConstraint(item: editLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: editLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 1.25).isActive = true
        
        NSLayoutConstraint(item: editLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 8).isActive = true
        
        editLabel.adjustsFontSizeToFitWidth = true
        editLabel.baselineAdjustment = .alignCenters
        
        let attEditLabel = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.height / 8)]
        let editLabelText = "Edit Profile"
        let attEdit = NSMutableAttributedString(string: editLabelText, attributes: attEditLabel)
        editLabel.attributedText = attEdit
        
        
        // email label
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint(item: emailLabel, attribute: .top, relatedBy: .equal, toItem: editLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 100).isActive = true
        
        
        //        NSLayoutConstraint(item: emailLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        
        NSLayoutConstraint(item: emailLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        
        
        NSLayoutConstraint(item: emailLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 6).isActive = true
        
        NSLayoutConstraint(item: emailLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 26).isActive = true
        
        
        
        
        let emailLabelAttribute = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.height / 26)]
        let emailLabelText = "Email"
        let AttributeEmailLabel = NSMutableAttributedString(string: emailLabelText, attributes: emailLabelAttribute)
        emailLabel.attributedText = AttributeEmailLabel
        
        emailLabel.adjustsFontSizeToFitWidth = true
        emailLabel.baselineAdjustment = .alignCenters
        
        emailLabel.textAlignment = .center
        
        
        //  EMAIL TEXTFIELD
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: emailTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: emailTextField, attribute: .top, relatedBy: .equal, toItem: emailLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 150).isActive = true
        
        NSLayoutConstraint(item: emailTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / (3/2)).isActive = true
        
        NSLayoutConstraint(item: emailTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40).isActive = true
        
        
        
        // CONSTRAINTS PASS LABEL
        
        passLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //        passLabel.layer.borderWidth = 0.5
        //        passLabel.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: passLabel, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 50).isActive = true
        
        
        NSLayoutConstraint(item: passLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        
        //        NSLayoutConstraint(item: passLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        
        NSLayoutConstraint(item: passLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 3).isActive = true
        
        NSLayoutConstraint(item: passLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 26).isActive = true
        
        
        passLabel.adjustsFontSizeToFitWidth = true
        passLabel.baselineAdjustment = .alignCenters
        passLabel.textAlignment = .center
        
        
        let passLabelAttribute = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.height / 26)]
        let passLabelText = "Password"
        let AttributePassLabel = NSMutableAttributedString(string: passLabelText, attributes: passLabelAttribute)
        passLabel.attributedText = AttributePassLabel
        
        
        // CONSTRAINTS PASS TEXTFIELD
        
        
        passTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: passTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: passTextField, attribute: .top, relatedBy: .equal, toItem: passLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 150).isActive = true
        
        NSLayoutConstraint(item: passTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / (3/2)).isActive = true
        
            NSLayoutConstraint(item: passTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40).isActive = true
        
        
    // USERNAME LABEL
        
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //        passLabel.layer.borderWidth = 0.5
        //        passLabel.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: passTextField, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 50).isActive = true
        
        
        NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        
        //        NSLayoutConstraint(item: passLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        
        NSLayoutConstraint(item: nameLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 3).isActive = true
        
        NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 26).isActive = true
        
        
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.baselineAdjustment = .alignCenters
        nameLabel.textAlignment = .center
        
        let nameLabelAttribute = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.height / 26)]
        let nameLabelText = "Username"
        let AttributeNameLabel = NSMutableAttributedString(string: nameLabelText, attributes: nameLabelAttribute)
        nameLabel.attributedText = AttributeNameLabel
        
        
        // USERNAME TEXTFIELD
        
        
        nickNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: nickNameTextField, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: nickNameTextField, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 150).isActive = true
        
        NSLayoutConstraint(item: nickNameTextField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / (3/2)).isActive = true
        
        NSLayoutConstraint(item: nickNameTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40).isActive = true
        
        
        // AVATAR LABEL
        
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint(item: avatarLabel, attribute: .top, relatedBy: .equal, toItem: nickNameTextField, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 50).isActive = true
        
        
        NSLayoutConstraint(item: avatarLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        
        //        NSLayoutConstraint(item: passLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        
        NSLayoutConstraint(item: avatarLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 3).isActive = true
        
        NSLayoutConstraint(item: avatarLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 26).isActive = true
        
        
        avatarLabel.adjustsFontSizeToFitWidth = true
        avatarLabel.baselineAdjustment = .alignCenters
        avatarLabel.textAlignment = .center
        
        
        let avatarLabelAttribute = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.height / 26)]
        let avatarLabelText = "Avatar"
        let AttributeAvatarLabel = NSMutableAttributedString(string: avatarLabelText, attributes: avatarLabelAttribute)
        avatarLabel.attributedText = AttributeAvatarLabel
        
        
        // STACK VIEW
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: avatarLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 100).isActive = true
        
        NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 1.25).isActive = true
        
        NSLayoutConstraint(item: stackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        
        stackView.distribution = .fillEqually
        stackView.contentMode = .scaleAspectFill
        
        
        // CAMERA BUTTON
        
        
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        
//        cameraButton.layer.borderWidth = 0.5
//        cameraButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: cameraButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: cameraButton, attribute: .top, relatedBy: .equal, toItem: stackView, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 25).isActive = true
        
        NSLayoutConstraint(item: cameraButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 5).isActive = true
        
        NSLayoutConstraint(item: cameraButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 12).isActive = true
        
        cameraButton.setImage(UIImage(named: "camera"), for: .normal)
        
        cameraButton.contentMode = .scaleAspectFill
        
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func avatarSelected(_ sender: UIButton) {
        
        EditProfileViewController.imageSelected = sender.imageView?.image
    }
    
    @IBAction func done(_ sender: Any) {
        
        self.activityIndicator.center = CGPoint(x: self.view.center.x, y: UIScreen.main.bounds.height / 6)
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(self.activityIndicator)
        
        self.activityIndicator.startAnimating()
        
        
        if nickNameTextField.text == "" && emailTextField.text == "" && passTextField.text == "" && EditProfileViewController.imageSelected == nil {
            let alertController = UIAlertController(title: "Error", message: "Nessuna modifica effettuata", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        else {
            
            let alert = UIAlertController(title: "Confermare le modifiche?", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                let ref = Database.database().reference()
                
                if self.nickNameTextField.text != "" {
                    
                    ref.child("Players").child("\(MainViewController.user.id)").child("nickname").setValue("\(ConvertOptionalString.convert(self.nickNameTextField.text!))")
                    
                    MainViewController.user.nickName = ConvertOptionalString.convert(self.nickNameTextField.text!)
                    MainViewController.user.stato = "online"
                    
                }
                if self.emailTextField.text != "" {
                    
                    if self.isValidEmail(testStr: ConvertOptionalString.convert(self.emailTextField.text!)) == false {
                        
                        let alertController = UIAlertController(title: "Error", message: "Please enter a valid email", preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                    Auth.auth().currentUser?.updateEmail(to: "\(ConvertOptionalString.convert(self.emailTextField.text!))", completion: nil)
                    ref.child("Players").child("\(MainViewController.user.id)").child("email").setValue("\(ConvertOptionalString.convert(self.emailTextField.text!))")
                    
                }
                
                if self.passTextField.text != "" {
                    
                    Auth.auth().currentUser?.updatePassword(to: "\(ConvertOptionalString.convert(self.passTextField.text!))", completion: nil)
                }
                
                if EditProfileViewController.imageSelected != nil {
                    
                    let uploadData = UIImagePNGRepresentation(self.resizeImage(image: EditProfileViewController.imageSelected))!
                    
                    let base64ImageString = uploadData.base64EncodedString()
                    
                    ref.child("Players").child("\(MainViewController.user.id)").child("image").setValue(base64ImageString)
                    
                    MainViewController.user.image = EditProfileViewController.imageSelected
                    self.dismiss(animated: true, completion: nil)
                }
                
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
            }))
            
            self.present(alert, animated: true)
        }
    }
    @IBAction func goProfile(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func camera(_ sender: UIButton) {
        
        let cameraView = UIStoryboard(name: "SignInANDSignUp", bundle: nil).instantiateViewController(withIdentifier: "camera")
        self.present(cameraView, animated: true, completion: nil)
    }
}
