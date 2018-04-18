//
//  ViewController.swift
//  ticTacToeEx
//
//  Created by Stefano Apuzzo on 26/03/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit
import FirebaseAuth

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        
    }
}

class MainViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var signInButton: UIButton!
    
    static var user = User()
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var rankingButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set constraints start button
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
//        startButton.layer.borderWidth = 0.5
//        startButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: startButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: startButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 3).isActive = true
        
        NSLayoutConstraint(item: startButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width - 50).isActive = true
        
        NSLayoutConstraint(item: startButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width - 50) / 4).isActive = true
        
        startButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        startButton.titleLabel?.font = UIFont(name: "shojumaru", size: 40)
    
        startButton.titleLabel?.baselineAdjustment = .alignCenters
        
        //set contraints ranking button
        
        rankingButton.translatesAutoresizingMaskIntoConstraints = false
        
//        rankingButton.layer.borderWidth = 0.5
//        rankingButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: rankingButton, attribute: .top, relatedBy: .equal, toItem: startButton, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 10).isActive = true
        
        NSLayoutConstraint(item: rankingButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: rankingButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width - 150).isActive = true
        
        NSLayoutConstraint(item: rankingButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width - 150) / 4).isActive = true
        rankingButton.titleLabel?.adjustsFontSizeToFitWidth = true
        rankingButton.titleLabel?.baselineAdjustment = .alignCenters
        rankingButton.titleLabel?.numberOfLines = 1
        
        //set constraints home button
        
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        homeButton.layer.borderWidth = 0.5
        homeButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: homeButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 10).isActive = true
        NSLayoutConstraint(item: homeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 10).isActive = true
        NSLayoutConstraint(item: homeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        NSLayoutConstraint(item: homeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        homeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        homeButton.titleLabel?.baselineAdjustment = .alignCenters
        
        homeButton.titleLabel?.font = UIFont(name: "shojumaru", size: 17)
        
        // constraints avatar button
        
        avatarButton.translatesAutoresizingMaskIntoConstraints = false
        avatarButton.layer.borderWidth = 1
        avatarButton.layer.borderColor = UIColor.blue.cgColor
        
        NSLayoutConstraint(item: avatarButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 10).isActive = true
        
        NSLayoutConstraint(item: avatarButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: (UIScreen.main.bounds.width / 10)*8).isActive = true

        NSLayoutConstraint(item: avatarButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        NSLayoutConstraint(item: avatarButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        //set constraits nickname label
        
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nickNameLabel.layer.borderWidth = 0.5
        nickNameLabel.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 10).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .right, relatedBy: .equal, toItem: avatarButton, attribute: .left, multiplier: 1, constant: -10).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        nickNameLabel.adjustsFontSizeToFitWidth = true 
//
//        NSLayoutConstraint(item: nickNameLabel, attribute: .centerY, relatedBy: .equal, toItem: avatarButton, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        
        nickNameLabel.adjustsFontSizeToFitWidth = true
        nickNameLabel.baselineAdjustment = .alignCenters
        
        nickNameLabel.font = UIFont(name: "catCafe", size: 20)
        
        // BACKGROUND
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: backgroundImage, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: backgroundImage, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        
        NSLayoutConstraint(item: backgroundImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width).isActive = true
        
        NSLayoutConstraint(item: backgroundImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height).isActive = true
        
        backgroundImage.contentMode = .scaleAspectFill
        
        
        
        if MainViewController.user.nickName == "" {
            
            self.avatarButton.isHidden = true
            self.nickNameLabel.isHidden = true
            self.startButton.isEnabled = false
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        if MainViewController.user.nickName == "" {
            self.avatarButton.isHidden = true
            self.nickNameLabel.isHidden = true
        }
        else{
            self.avatarButton.isHidden = false
            self.nickNameLabel.isHidden = false
            self.startButton.isEnabled = true
            self.avatarButton.setBackgroundImage(MainViewController.user.image, for: .normal)
            //self.avatarButton.transform = CGAffineTransform(rotationAngle: (90.0 * .pi) / 180.0)
            self.avatarButton.layer.cornerRadius = UIScreen.main.bounds.width / 20
            self.avatarButton.layer.masksToBounds = true
            
            self.nickNameLabel.text = MainViewController.user.nickName
        }
    }

    @IBAction func signIn(_ sender: Any) {
        
        let signInView = UIStoryboard(name: "SignInANDSignUp", bundle: nil).instantiateViewController(withIdentifier: "signIn")
        self.present(signInView, animated: true, completion: nil)
    }
    @IBAction func ranking(_ sender: Any) {
        
        let rankingView = UIStoryboard(name: "Ranking", bundle: nil).instantiateViewController(withIdentifier: "rankingList")
        self.present(rankingView, animated: true, completion: nil)
    }
    
    @IBAction func showProfile(_ sender: Any) {
        
        let rankingView = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "profileInfo")
        self.present(rankingView, animated: true, completion: nil)
    }
    @IBAction func startGame(_ sender: Any) {
        
        let startGameView = UIStoryboard(name: "LobbyANDGame", bundle: nil).instantiateViewController(withIdentifier: "lobby")
        self.present(startGameView, animated: true, completion: nil)
    }
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.avatarButton.isHidden = true
            self.nickNameLabel.isHidden = true
            self.startButton.isEnabled = false
            MainViewController.user = User()
            
        }
        catch {
            print("Log out failed")
        }
    }
    
    @IBAction func homeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

