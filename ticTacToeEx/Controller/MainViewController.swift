//
//  ViewController.swift
//  ticTacToeEx
//
//  Created by Stefano Apuzzo on 26/03/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit

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
    
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if MainViewController.user.nickName == "" {
            self.avatarButton.isHidden = true
            self.nickNameLabel.isHidden = true
            self.startButton.isEnabled = false
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "cherryTree")
//        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
//        self.view.insertSubview(backgroundImage, at: 0)
        
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
            
            self.avatarButton.setImage(MainViewController.user.image, for: .normal)
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
        
        let rankingView = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "pfofileInfo")
        self.present(rankingView, animated: true, completion: nil)
    }
    @IBAction func startGame(_ sender: Any) {
        
        let startGameView = UIStoryboard(name: "LobbyANDGame", bundle: nil).instantiateViewController(withIdentifier: "lobby")
        self.present(startGameView, animated: true, completion: nil)
    }
}

