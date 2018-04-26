//
//  startingViewController.swift
//  ticTacToeEx
//
//  Created by CertimeterGroup on 16/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController, Lobby {
    
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var rankingButton: UIButton!
    
    @IBAction func avatarButton(_ sender: Any) {
        
        let profile = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "profileInfo")
        self.present(profile,animated: true,completion: nil)
        
    }
    
    func presentLobby() {
        
        let segue = UIStoryboard(name:"Lobby",bundle:nil).instantiateViewController(withIdentifier: "lobby") as! LobbyViewController
        
        self.present(segue, animated: true)
    }
    
    @IBAction func trisButton(_ sender: Any) {
        if MainViewController.user.nickName != ""{
            let storyboard = UIStoryboard(name: "Lobby", bundle: nil).instantiateViewController(withIdentifier: "lobby")
            self.present(storyboard, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "Ops...", message: "Devi prima fare il login", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let defaultAction = UIAlertAction(title: "Sign In", style: .default, handler: { _ in
                let storyboard = UIStoryboard(name: "SignInANDSignUp", bundle: nil).instantiateViewController(withIdentifier: "signIn")
                self.present(storyboard, animated: true, completion: nil)
            })
            
            alertController.addAction(defaultAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
            print("\n\nConnettiti\n\n")
        }
    }
    
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var SMConstraint: NSLayoutConstraint!
    @IBOutlet weak var conteinerView: UIView!
    
    @IBOutlet weak var trisButton: UIButton!
    var sideMenuConstraint: NSLayoutConstraint!
    var isSlideMenuHidden = true
    
    static var first: Bool!
    
    func signOut(notification: Notification) {
        self.avatarButton.isHidden = true
        self.nickNameLabel.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //observer signOut
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue:"LogOut"), object: nil, queue: nil, using: signOut)
        
        StartingViewController.first = true
        //swipe
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
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
         //-------------------------
        //sideMenuConstraints
        sideMenuView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: sideMenuView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: sideMenuView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: sideMenuView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width / 2) + 50).isActive = true
        SMConstraint.constant = -(UIScreen.main.bounds.width / 2) - 50
        
        sideMenuView.backgroundColor = UIColor.clear
        
        //menu button constraints
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
//        menuButton.layer.borderColor = UIColor.white.cgColor
//        menuButton.layer.borderWidth = 0.5
        
        NSLayoutConstraint(item: menuButton, attribute: .left, relatedBy: .equal, toItem: sideMenuView, attribute: .right, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        NSLayoutConstraint(item: menuButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 10).isActive = true
        NSLayoutConstraint(item: menuButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 8).isActive = true
        NSLayoutConstraint(item: menuButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 8).isActive = true
        
        menuButton.setImage(UIImage(named: "menuButton"), for: .normal)
        menuButton.tintColor = UIColor.white
        
        
//        menuButton.titleLabel?.adjustsFontSizeToFitWidth = true
//        menuButton.titleLabel?.baselineAdjustment = .alignCenters
        
        //conteiner view constrains
        
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: conteinerView, attribute: .top, relatedBy: .equal, toItem: sideMenuView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: conteinerView, attribute: .bottom, relatedBy: .equal, toItem: sideMenuView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: conteinerView, attribute: .left, relatedBy: .equal, toItem: sideMenuView, attribute: .left, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: conteinerView, attribute: .right, relatedBy: .equal, toItem: sideMenuView, attribute: .right, multiplier: 1, constant: 0).isActive = true
 
        // TRIS BUTTON
        
        trisButton.translatesAutoresizingMaskIntoConstraints = false
        
        trisButton.layer.borderWidth = 0.5
        trisButton.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint(item: trisButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.size.height / 3).isActive = true
        
//        NSLayoutConstraint(item: trisButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: trisButton, attribute: .left, relatedBy: .equal, toItem: sideMenuView, attribute: .right, multiplier: 1, constant: (UIScreen.main.bounds.width - (UIScreen.main.bounds.width / 1.25)) / 2).isActive = true
        
        
        
        NSLayoutConstraint(item: trisButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 1.25).isActive = true
        
         NSLayoutConstraint(item: trisButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 8).isActive = true
        
        trisButton.setTitle("Start Game", for: .normal)
        trisButton.titleLabel?.font = UIFont(name: "Raleway-Light", size: UIScreen.main.bounds.size.height / 8)
        
        trisButton.setTitleColor(UIColor.white, for: .normal)
        
        trisButton.titleLabel?.adjustsFontSizeToFitWidth = true
        trisButton.titleLabel?.baselineAdjustment = .alignCenters
        
        
        
        
        // RANKING BUTTON
        
        rankingButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint(item: rankingButton, attribute: .top, relatedBy: .equal, toItem: trisButton, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 10).isActive = true
        
//        NSLayoutConstraint(item: rankingButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: rankingButton, attribute: .left, relatedBy: .equal, toItem: sideMenuView, attribute: .right, multiplier: 1, constant: UIScreen.main.bounds.width / 4).isActive = true
        
        
        NSLayoutConstraint(item: rankingButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 2).isActive = true
        
        NSLayoutConstraint(item: rankingButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 9).isActive = true
        
        rankingButton.setTitle("Ranking", for: .normal)
        rankingButton.setTitleColor(UIColor.white, for: .normal)
        rankingButton.titleLabel?.font = UIFont(name: "raleway", size: UIScreen.main.bounds.size.height / 9)
        
        rankingButton.titleLabel?.adjustsFontSizeToFitWidth = true
        rankingButton.titleLabel?.baselineAdjustment = .alignCenters
        

        
        

        
        
        // constraints avatar button
        
        avatarButton.translatesAutoresizingMaskIntoConstraints = false
//                avatarButton.layer.borderWidth = 1
//                avatarButton.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint(item: avatarButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 12).isActive = true
        
        NSLayoutConstraint(item: avatarButton, attribute: .left, relatedBy: .equal, toItem: sideMenuView, attribute: .right, multiplier: 1, constant: (UIScreen.main.bounds.width / 10)*7).isActive = true
        
        NSLayoutConstraint(item: avatarButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 6).isActive = true
        
        NSLayoutConstraint(item: avatarButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 6).isActive = true
        
        
        avatarButton.imageView?.contentMode = .scaleAspectFill
        avatarButton.imageView?.layer.cornerRadius = (UIScreen.main.bounds.width / 8) / 2
        
        avatarButton.backgroundColor = UIColor.clear
        
        
        
        //set constraits nickname label
        
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
//                nickNameLabel.layer.borderWidth = 0.5
//                nickNameLabel.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .top, relatedBy: .equal, toItem: avatarButton, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .left, relatedBy: .equal, toItem: sideMenuView, attribute: .right, multiplier: 1, constant: (UIScreen.main.bounds.width / 10)*6).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 3).isActive = true
        
        nickNameLabel.adjustsFontSizeToFitWidth = true
        nickNameLabel.baselineAdjustment = .alignCenters
        nickNameLabel.textAlignment = .center
        
        //
        
        //        NSLayoutConstraint(item: nickNameLabel, attribute: .centerY, relatedBy: .equal, toItem: avatarButton, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        nickNameLabel.baselineAdjustment = .alignCenters
        
        nickNameLabel.font = UIFont(name: "Raleway-Light", size: UIScreen.main.bounds.height / 40)
        nickNameLabel.textColor = UIColor.white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !StartingViewController.first && MainViewController.user.nickName != ""{
            hideSideMenu()
            isSlideMenuHidden = true
        }
        StartingViewController.first = false
    }
    
    @IBAction func menuButtonAction(_ sender: UIButton) {
        if isSlideMenuHidden{
            showSideMenu()
        }else{
            hideSideMenu()
        }
        isSlideMenuHidden = !isSlideMenuHidden
        
        if MainViewController.user.nickName == ""{
            nickNameLabel.isHidden = true
            
            avatarButton.isHidden = true
        }
    }
    
    @IBAction func rankingAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Ranking", bundle: nil).instantiateViewController(withIdentifier: "rankingList")
        self.present(storyboard, animated: true, completion: nil)
    }
    
    
    func showSideMenu(){
        SMConstraint.constant = 0
        
        trisButton.isHidden = true
        rankingButton.isHidden = true
        nickNameLabel.isHidden = true
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func hideSideMenu(){
        SMConstraint.constant = -(UIScreen.main.bounds.width / 2) - 50
        
        trisButton.isHidden = false
        rankingButton.isHidden = false
        nickNameLabel.isHidden = false
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if MainViewController.user.nickName == "" {
            self.avatarButton.isHidden = true
            self.nickNameLabel.isHidden = true
        }
        else{
            self.avatarButton.isHidden = false
            self.nickNameLabel.isHidden = false
            self.avatarButton.setBackgroundImage(MainViewController.user.image, for: .normal)
            self.avatarButton.layer.cornerRadius = (UIScreen.main.bounds.width / 6) / 2
            self.avatarButton.layer.masksToBounds = true
            self.avatarButton.imageView?.contentMode = .scaleAspectFill
            
            self.nickNameLabel.text = MainViewController.user.nickName
        }
    }

    @objc func swipeAction(swipe: UISwipeGestureRecognizer){
        if swipe.direction == .right && isSlideMenuHidden{
            showSideMenu()
            isSlideMenuHidden = !isSlideMenuHidden
            
        }else if swipe.direction == .left && !isSlideMenuHidden{
            hideSideMenu()
            isSlideMenuHidden = !isSlideMenuHidden
        }
        
    }
}
