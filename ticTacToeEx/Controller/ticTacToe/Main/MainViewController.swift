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
        
        NSLayoutConstraint(item: startButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 1.25).isActive = true
        
        NSLayoutConstraint(item: startButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 7).isActive = true
        
        startButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        startButton.setTitle("Start Game", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "shojumaru", size: UIScreen.main.bounds.size.height / 7)
        
       
        
        
        
        startButton.titleLabel?.baselineAdjustment = .alignCenters
        
        //set contraints ranking button
        
        rankingButton.translatesAutoresizingMaskIntoConstraints = false
        
//        rankingButton.layer.borderWidth = 0.5
//        rankingButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: rankingButton, attribute: .top, relatedBy: .equal, toItem: startButton, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 20).isActive = true
        
        NSLayoutConstraint(item: rankingButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: rankingButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width/1.25).isActive = true
        
        NSLayoutConstraint(item: rankingButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 16).isActive = true
            
        
        rankingButton.setTitle("Ranking", for: .normal)
        rankingButton.titleLabel?.font = UIFont(name: "shojumaru", size: UIScreen.main.bounds.height / 26)
        rankingButton.titleLabel?.adjustsFontSizeToFitWidth = true
        rankingButton.titleLabel?.baselineAdjustment = .alignCenters
        
        //set constraints home button
        
        homeButton.translatesAutoresizingMaskIntoConstraints = false
//        homeButton.layer.borderWidth = 0.5
//        homeButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: homeButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        NSLayoutConstraint(item: homeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 15).isActive = true
        NSLayoutConstraint(item: homeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        NSLayoutConstraint(item: homeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        homeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        homeButton.titleLabel?.baselineAdjustment = .alignCenters
        
        
        
        
    
        
        
        homeButton.titleLabel?.font = UIFont(name: "shojumaru", size: UIScreen.main.bounds.width / 7)
        
        // constraints avatar button
        
        avatarButton.translatesAutoresizingMaskIntoConstraints = false
//        avatarButton.layer.borderWidth = 1
//        avatarButton.layer.borderColor = UIColor.blue.cgColor
        
        NSLayoutConstraint(item: avatarButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 12.5).isActive = true
        
        NSLayoutConstraint(item: avatarButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: (UIScreen.main.bounds.width / 10)*8).isActive = true

        NSLayoutConstraint(item: avatarButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 10).isActive = true
        
        NSLayoutConstraint(item: avatarButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 10).isActive = true
        
        
        avatarButton.imageView?.contentMode = .scaleAspectFill
        avatarButton.imageView?.layer.cornerRadius = (UIScreen.main.bounds.width / 7) / 2
        
        avatarButton.backgroundColor = UIColor.clear
        
        
        
        
        
        
        
        
        //set constraits nickname label
        
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        nickNameLabel.layer.borderWidth = 0.5
//        nickNameLabel.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 15).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .right, relatedBy: .equal, toItem: avatarButton, attribute: .left, multiplier: 1, constant: -10).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 2).isActive = true
        
        nickNameLabel.adjustsFontSizeToFitWidth = true
        nickNameLabel.textAlignment = .right
        
//
        
//        NSLayoutConstraint(item: nickNameLabel, attribute: .centerY, relatedBy: .equal, toItem: avatarButton, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        nickNameLabel.baselineAdjustment = .alignCenters
        
        nickNameLabel.font = UIFont(name: "catCafe", size: UIScreen.main.bounds.height / 23)
        
        
        
        
        
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
        
        let startGameView = UIStoryboard(name: "Lobby", bundle: nil).instantiateViewController(withIdentifier: "lobby")
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

