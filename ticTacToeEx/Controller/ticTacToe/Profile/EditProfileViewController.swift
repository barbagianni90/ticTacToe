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
        
        if nickNameTextField.text == "" && emailTextField.text == "" && passTextField.text == "" && EditProfileViewController.imageSelected == nil {
            let alertController = UIAlertController(title: "Error", message: "Nessuna modifica effettuata", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        else {
            
            let alert = UIAlertController(title: "Confermare le modifiche?", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                self.activityIndicator.center = self.view.center
                self.activityIndicator.hidesWhenStopped = true
                self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                self.view.addSubview(self.activityIndicator)
                
                self.activityIndicator.startAnimating()
                UIApplication.shared.beginIgnoringInteractionEvents()
                
                let ref = Database.database().reference()
                
                if self.nickNameTextField.text != "" {
                    
                    ref.child("Players").child("\(MainViewController.user.id)").child("nickname").setValue("\(self.nickNameTextField.text as! String)")
                    
                    MainViewController.user.nickName = self.nickNameTextField.text as! String
                    MainViewController.user.stato = "online"
                    
                }
                if self.emailTextField.text != "" {
                    
                    if self.isValidEmail(testStr: self.emailTextField.text as! String) == false {
                        
                        let alertController = UIAlertController(title: "Error", message: "Please enter a valid email", preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                    Auth.auth().currentUser?.updateEmail(to: "\(self.emailTextField.text as! String)", completion: nil)
                    ref.child("Players").child("\(MainViewController.user.id)").child("email").setValue("\(self.emailTextField.text as! String)")
                    
                }
                
                if self.passTextField.text != "" {
                    
                    Auth.auth().currentUser?.updatePassword(to: "\(self.passTextField.text as! String)", completion: nil)
                }
                
                if EditProfileViewController.imageSelected != nil {
                    
                    let uploadData = UIImagePNGRepresentation(self.resizeImage(image: EditProfileViewController.imageSelected))!
                    
                    let base64ImageString = uploadData.base64EncodedString()
                    
                    ref.child("Players").child("\(MainViewController.user.id)").child("image").setValue(base64ImageString)
                    
                    MainViewController.user.image = EditProfileViewController.imageSelected
                    self.dismiss(animated: true, completion: nil)
                }
            }))
            
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
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
