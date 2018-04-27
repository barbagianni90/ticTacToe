//
//  GameTrisViewController.swift
//  ticTacToeEx
//
//  Created by Stefano Apuzzo on 28/03/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Utils{
    
    static func collectionToArray2D(arr: [UIButton],size: Int) -> [[UIButton]]{
        
        var result : [[UIButton]] = [[UIButton]](repeating: [UIButton](), count: size);
        var set = -1;
        let expectedSize = (arr.count / size) + (arr.count % size);
        
        for i in 0..<arr.count {
            if i % expectedSize == 0{
                set = set + 1;
            }
            
            result[set].append(arr[i]);
        }
        
        return result;
    }
    
}

class GameTrisViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    //----------------------Chat-------------------------
    
    @IBOutlet weak var chatViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var chatTable: UITableView!
    
    @IBOutlet weak var bottomTextField: NSLayoutConstraint!
    
    @IBOutlet weak var textFieldMessage: UITextField!
    
    @IBAction func dismissButton(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Abbandona", message: "Are you sure?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Si", style: .default, handler: { (action) in
            
            let ref = Database.database().reference()
            
            if LobbyViewController.gameSelected == "tris" {
                ref.child("Players").child("\(MainViewController.user.id)").child("sconfitteTris").setValue("\(MainViewController.user.sconfitteTris + 1)")
            }
            else if LobbyViewController.gameSelected == "dama" {
                ref.child("Players").child("\(MainViewController.user.id)").child("sconfitteDama").setValue("\(MainViewController.user.sconfitteDama + 1)")
            }
            ref.child("Players").child("\(MainViewController.user.id)").child("invitatoDa").setValue("")
            ref.child("Players").child("\(MainViewController.user.id)").child("invitoAccettato").setValue("")
            ref.child("Players").child("\(MainViewController.user.id)").child("stato").setValue("online")
            ref.child("Utility\(self.nomeTabella)").child("abbandona").setValue("\(MainViewController.user.nickName)")
            
            ref.child("\(self.nomeTabella)").removeAllObservers()
            ref.child("Utility\(self.nomeTabella)").removeAllObservers()
            ref.child("Messages\(self.nomeTabella)").removeAllObservers()
            
            self.partitaFinita = true
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
        }))
        self.present(alert,animated: true, completion: nil)
            
    }
    
    var messages: [Message] = []
    
    var messagesTot: Int = 0
    
    var textFieldTouched: UITextField?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if messages[indexPath.row].nickName == MainViewController.user.nickName {
            
            let cell = chatTable.dequeueReusableCell(withIdentifier: "cellUser", for: indexPath) as! CustomUserChatCell
            
            cell.imageProfile.image = MainViewController.user.image
            
            cell.imageProfile.layer.cornerRadius = cell.imageProfile.frame.width / 2
            
            cell.imageProfile.layer.masksToBounds = true
            
            cell.nickNameLabel.text = MainViewController.user.nickName
//            cell.nickNameLabel.layer.borderWidth = 0.5
//            cell.nickNameLabel.layer.borderColor = UIColor.white.cgColor
            cell.nickNameLabel.textColor = UIColor.white

            cell.nickNameLabel.font = UIFont(name: "Roboto-Regular", size: UIScreen.main.bounds.size.height / 35)
            cell.nickNameLabel.adjustsFontSizeToFitWidth = true

            
            cell.messageLabel.text = messages[indexPath.row].message
            cell.messageLabel.textColor = UIColor.white
//            cell.messageLabel.layer.borderWidth = 0.5
//            cell.messageLabel.layer.borderColor = UIColor.white.cgColor
            
            cell.messageLabel.textAlignment = .right
            
            cell.messageLabel.font = UIFont(name: "raleway", size: UIScreen.main.bounds.size.height / 40)
            cell.messageLabel.adjustsFontSizeToFitWidth = true

            cell.isUserInteractionEnabled = false
            
           
            
            return cell
        }
        
        else {
            
            let cell = chatTable.dequeueReusableCell(withIdentifier: "cellEnemy", for: indexPath) as! CustomEnemyChatCell
            
            cell.imageProfile.image = self.enemy.image
            
            cell.imageProfile.layer.cornerRadius = cell.imageProfile.frame.width / 2
            
            cell.imageProfile.layer.masksToBounds = true
            
            cell.nickNameLabel.text = self.enemy.nickName
            cell.nickNameLabel.textColor = UIColor.white
            
            cell.nickNameLabel.font = UIFont(name: "Roboto-Regular", size: UIScreen.main.bounds.size.height / 35)
            
            cell.nickNameLabel.adjustsFontSizeToFitWidth = true
            
            cell.messageLabel.text = messages[indexPath.row].message
            cell.messageLabel.textColor = UIColor.white

            cell.messageLabel.textAlignment = .left
            
            cell.messageLabel.font = UIFont(name: "raleway", size: UIScreen.main.bounds.size.height / 40)
            
            cell.messageLabel.adjustsFontSizeToFitWidth = true
            
            cell.isUserInteractionEnabled = false

            

            return cell
        }
        
        
       
    }
    
    
    func scrollToLastRow() {
        if messages.count > 0 {
        let indexPath =  IndexPath.init(row: messages.count - 1,section: 0)
        chatTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = textField as? UITextField {
            textFieldTouched = textField
            self.textFieldTouched = textField
        }
        else {
            print("Error textfield")
        }
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        
        let info = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
         self.bottomTextField.constant = keyboardSize.height + 8.0
        if self.view.frame.origin.y >= 0 {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                self.textFieldTouched?.layoutIfNeeded()
            }, completion: nil)
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        
        self.bottomTextField.constant = 3
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.textFieldTouched?.layoutIfNeeded()
        }, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  //if desired
        performAction()
        return true
    }
    
    @IBOutlet weak var dismissButton: UIButton!
    
    
    
    func performAction() {
        let ref = Database.database().reference()
        let messageText = ConvertOptionalString.convert(self.textFieldTouched?.text!)
        let message = [
            "Message" : "\(messageText)",
            "Nickname" : "\(MainViewController.user.nickName)"
        ]
        let newMessageNumber = self.messagesTot + 1
        ref.child("Messages\(nomeTabella)").child("Message\(newMessageNumber)").setValue(message)
        self.textFieldTouched?.text = ""
    }
    
    
    @IBAction func chatAction(_ sender: UIButton) {
        showChawView()
    }
    @IBAction func xButtonAction(_ sender: Any) {
        hideChatView()
    }
    
    func showChawView(){
        textFieldMessage.becomeFirstResponder()
        
        chatViewTop.constant = UIScreen.main.bounds.height / 4
        trisImage.alpha = 0.3
        stackView.alpha = 0.3
        for i in buttons{
            i.isEnabled = false
        }
        chatButton.isHidden = true
        xButton.isHidden = false
        chatButton.setTitleColor(UIColor.white, for: .normal)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func hideChatView(){
        chatViewTop.constant = UIScreen.main.bounds.height
        trisImage.alpha = 1
        stackView.alpha = 1
        for i in buttons{
            i.isEnabled = true
        }
        
        chatButton.isHidden = false
        xButton.isHidden = true
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    //----------------------Game-------------------------
    
    
    
    
    @IBOutlet weak var xButton: UIButton!
    
    @IBOutlet weak var chatButton: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var trisImage: UIImageView!
    
    @IBOutlet weak var chatView: UIView!
    
    var enemy = User()
    
    var fPlayer = false
    var sPlayer = false
    
    var nomeTabella = ""
    
    var vittorie: Int!
    var sconfitte: Int!
    
    var matrice: [[String]] = [["", "", ""], ["", "", ""],["","",""]]
    
    var myImage: UIImage!
    var oppositeImage: UIImage!
    
    @IBOutlet var buttons: [UIButton]!
    var buttons2D: [[UIButton]]!
    var buttonEnabled = 9
    
    var partitaFinita = false {
        didSet {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        
        
        
        //setting stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        //top
        NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: trisImage, attribute: .top, multiplier: 1, constant:0).isActive = true
        
        
        //bottom
        NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: trisImage, attribute: .bottom, multiplier: 1, constant: (UIScreen.main.bounds.width / 100) * 2).isActive = true
     
        
        //left
        NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: trisImage, attribute: .left, multiplier: 1, constant: 0).isActive = true
//
//
        //right
        NSLayoutConstraint(item: stackView, attribute: .right, relatedBy: .equal, toItem: trisImage, attribute: .right, multiplier: 1, constant:(UIScreen.main.bounds.width / 100) * 2).isActive = true
        
        
     
        
        stackView.distribution = .fillEqually
        
        
        //setting tris image
        
        
        trisImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        //top
//        NSLayoutConstraint(item: trisImage, attribute: .top, relatedBy: .equal, toItem: dismissButton, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 15).isActive = true
        //centerY
        NSLayoutConstraint(item: trisImage, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        //centerX
        NSLayoutConstraint(item: trisImage, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        //width
        NSLayoutConstraint(item: trisImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width / 100) * 78).isActive = true
        //height
        NSLayoutConstraint(item: trisImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width / 100) * 78).isActive = true
        
        trisImage.contentMode = .scaleAspectFill
        
        
        //CHAT VIEW
        
        chatView.translatesAutoresizingMaskIntoConstraints = false
        
//        NSLayoutConstraint(item: chatView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.size.width / 15).isActive = true
//
//        NSLayoutConstraint(item: chatView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: UIScreen.main.bounds.size.width / -15).isActive = true
        
//        NSLayoutConstraint(item: chatView, attribute: .top, relatedBy: .equal, toItem: trisImage, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 16).isActive = true
        
//        NSLayoutConstraint(item: chatView, attribute: .bottom, relatedBy: .equal, toItem: textFieldMessage, attribute: .top, multiplier: 1, constant: 0).isActive = true
        //width
        NSLayoutConstraint(item: chatView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width).isActive = true
        //centerx
        NSLayoutConstraint(item: chatView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        //height
        NSLayoutConstraint(item: chatView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.size.height / 4) * 3).isActive = true
        
        chatViewTop.constant = UIScreen.main.bounds.height
        
        chatView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
        
        
        
        
//        NSLayoutConstraint(item: chatView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: textFieldMessage.bounds.height).isActive = true
        
        //text field message
        
        textFieldMessage.translatesAutoresizingMaskIntoConstraints = false
        
//        //left
//        NSLayoutConstraint(item: textFieldMessage, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.size.width / 15).isActive = true
//        //right
//        NSLayoutConstraint(item: textFieldMessage, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -10).isActive = true
        //CenterX
        NSLayoutConstraint(item: textFieldMessage, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        //width
        NSLayoutConstraint(item: textFieldMessage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 1.1).isActive = true
//
        //height
        NSLayoutConstraint(item: textFieldMessage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 20).isActive = true
        
//        NSLayoutConstraint(item: textFieldMessage, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / -30).isActive = true
        
        
        //chat table
        
        chatTable.translatesAutoresizingMaskIntoConstraints = false
        //top
        NSLayoutConstraint(item: chatTable, attribute: .top, relatedBy: .equal, toItem: xButton, attribute: .bottom, multiplier: 1, constant: 0 ).isActive = true
        
        //bottom
        NSLayoutConstraint(item: chatTable, attribute: .bottom, relatedBy: .equal, toItem: chatView, attribute: .bottom, multiplier: 1, constant: -UIScreen.main.bounds.size.height / 20).isActive = true
        //left
        NSLayoutConstraint(item: chatTable, attribute: .left, relatedBy: .equal, toItem: chatView, attribute: .left, multiplier: 1, constant: 0).isActive = true
        //right
        NSLayoutConstraint(item: chatTable, attribute: .right, relatedBy: .equal, toItem: chatView, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        
        // TASTO ABBANDONA
        
        
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
//        dismissButton.layer.borderWidth = 0.5
//        dismissButton.layer.borderColor = UIColor.white.cgColor
        
        
        //top
        NSLayoutConstraint(item: dismissButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 28).isActive = true
        
        //right
        NSLayoutConstraint(item: dismissButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        
        //width
        NSLayoutConstraint(item: dismissButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        //height
        NSLayoutConstraint(item: dismissButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 8).isActive = true
        
        
        dismissButton.setTitle("Quit", for: .normal)
        dismissButton.setTitleColor(UIColor.white, for: .normal)
        
        dismissButton.titleLabel?.font = UIFont(name: "raleway", size: UIScreen.main.bounds.width / 4)
        
        dismissButton.titleLabel?.adjustsFontSizeToFitWidth = true
        dismissButton.titleLabel?.baselineAdjustment = .alignCenters
        
        
        
        
        //Chat Button
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        
//        chatButton.layer.borderWidth = 0.5
//        chatButton.layer.borderColor = UIColor.white.cgColor
        
        //top
        NSLayoutConstraint(item: chatButton, attribute: .top, relatedBy: .equal, toItem: trisImage, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 10).isActive = true
        
        //bottom
//        NSLayoutConstraint(item: chatButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        //right
//        NSLayoutConstraint(item: chatButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -UIScreen.main.bounds.width / 10).isActive = true
        
        //centerx
        NSLayoutConstraint(item: chatButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        //width
        NSLayoutConstraint(item: chatButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 2).isActive = true
        
        //height
        NSLayoutConstraint(item: chatButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 6).isActive = true
        
        chatButton.setTitle("Chat with: \(enemy.nickName)", for: .normal)
        chatButton.titleLabel?.font = UIFont(name: "raleway", size: UIScreen.main.bounds.width / 7)
        chatButton.setTitleColor(UIColor.white, for: .normal)
        
        chatButton.titleLabel?.baselineAdjustment = .alignCenters
        chatButton.titleLabel?.adjustsFontSizeToFitWidth = true
        chatButton.titleLabel?.textAlignment = .center
        
        chatButton.layer.borderColor = UIColor.white.cgColor
        chatButton.layer.borderWidth = 0.5
        chatButton.layer.cornerRadius =  15
        
        
        
        //xButton
        xButton.translatesAutoresizingMaskIntoConstraints = false
        
//        xButton.layer.borderWidth = 0.5
//        xButton.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint(item: xButton, attribute: .top, relatedBy: .equal, toItem: chatView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: xButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        //
        
        

        
        let ref = Database.database().reference()
        
        if fPlayer == true && sPlayer == false {
            
            nomeTabella = "\(MainViewController.user.nickName)VS\(self.enemy.nickName)"
        }
        else if fPlayer == false && sPlayer == true {
            
            nomeTabella = "\(self.enemy.nickName)VS\(MainViewController.user.nickName)"
        }
        
        for i in 0...2 {
            for y in 0...2 {
                ref.child("\(nomeTabella)").child("\(i):\(y)").child("toccata").setValue("")
                ref.child("\(nomeTabella)").child("\(i):\(y)").child("daChi").setValue("")
            }
        }
        ref.child("Utility\(nomeTabella)").child("buttonEnabled").setValue("9")
        ref.child("Utility\(nomeTabella)").child("abbandona").setValue("No")
        self.buttonEnabled = 9
        
        
        buttons2D = Utils.collectionToArray2D(arr: buttons, size: 3)
        
//        for buttons in buttons2D {
//            for button in buttons {
//                button.layer.borderColor = UIColor.black.cgColor
//                button.layer.borderWidth = 1
//            }
//        }
        
        
        if fPlayer == true {
            myImage = UIImage(named: "cross")
            oppositeImage = UIImage(named: "cerchio")
        }
        else if sPlayer == true {
            myImage = UIImage(named: "cerchio")
            oppositeImage = UIImage(named: "cross")
        }
        
        self.chatTable.delegate = self
        self.chatTable.dataSource = self
        self.textFieldMessage.delegate = self
        
        let center = NotificationCenter.default
        
        center.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.hideKeyboardWhenTappedAround()
        
        ref.child("Messages\(nomeTabella)").child("Message0").setValue(["Nickname" : "", "Message" : ""])
        
        ref.child("Messages\(nomeTabella)").observe(.value) { (snap) in
            
            self.messages.removeAll()
            
            if  snap.value != nil {
                
                let dict = snap.value as! [String : Any]
                
                let n_key = dict.count
                self.messagesTot = n_key - 1
                
                for(key, value) in dict {
                    let keyMessage = key as String
                    let n_message = ConvertOptionalString.extractNumberMessage(keyMessage)
                    
                    if n_message != "0" {
                        let dict2 = value as! [String : Any]
                        let message = Message()
                        message.nickName = dict2["Nickname"] as! String
                        message.message = dict2["Message"] as! String
                        message.n_message = Int(n_message)!
                        self.messages.append(message)
                    }
                }
                self.messages.sort(by: {$0.n_message < $1.n_message})
                self.chatTable.reloadData()
                
                if(self.messages.count > 0) && self.chatViewTop.constant == UIScreen.main.bounds.height{
                    self.chatButton.setTitleColor(UIColor.red, for: .normal)
                }
                self.scrollToLastRow()

            }
        
        }
        
        
        ref.child("Utility\(nomeTabella)").observe(.value) { (snap) in
            
            let utility = snap.value as! [String : Any]
            
            let quit = utility["abbandona"] as! String
            self.buttonEnabled = Int(utility["buttonEnabled"] as! String)!
            
            if quit == self.enemy.nickName {
                
                let alert = UIAlertController(title: "L'avversario ha abbandonato la partita", message: nil, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                    if LobbyViewController.gameSelected == "tris" {
                        ref.child("Players").child("\(MainViewController.user.id)").child("sconfitteTris").setValue("\(MainViewController.user.vittorieTris + 1)")
                    }
                    else if LobbyViewController.gameSelected == "dama" {
                        ref.child("Players").child("\(MainViewController.user.id)").child("sconfitteDama").setValue("\(MainViewController.user.vittorieDama + 1)")
                    }
                    
                    ref.child("Players").child("\(MainViewController.user.id)").child("invitatoDa").setValue("")
                    ref.child("Players").child("\(MainViewController.user.id)").child("invitoAccettato").setValue("")
                    ref.child("Players").child("\(MainViewController.user.id)").child("stato").setValue("online")
                    
                    ref.child("\(self.nomeTabella)").removeAllObservers()
                    ref.child("Utility\(self.nomeTabella)").removeAllObservers()
                    ref.child("Messages\(self.nomeTabella)").removeAllObservers()
                    
                    ref.child("\(self.nomeTabella)").removeValue()
                    ref.child("Utility\(self.nomeTabella)").removeValue()
                    ref.child("Messages\(self.nomeTabella)").removeValue()
                    
                    self.partitaFinita = true
                }))
                
                self.present(alert, animated: true)
            }
            
            if self.buttonEnabled == 0 && self.getWinner() == "" && self.sPlayer == true {
                
                ref.child("Players").child("\(MainViewController.user.id)").child("invitatoDa").setValue("")
                ref.child("Players").child("\(MainViewController.user.id)").child("invitoAccettato").setValue("")
                ref.child("Players").child("\(MainViewController.user.id)").child("stato").setValue("online")
                
                ref.child("\(self.nomeTabella)").removeAllObservers()
                ref.child("Utility\(self.nomeTabella)").removeAllObservers()
                ref.child("Messages\(self.nomeTabella)").removeAllObservers()
                
                ref.child("\(self.nomeTabella)").removeValue()
                ref.child("Utility\(self.nomeTabella)").removeValue()
                ref.child("Messages\(self.nomeTabella)").removeValue()
                
                let alert = UIAlertController(title: "Pareggio", message: "", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.partitaFinita = true
                }))
                
                self.present(alert, animated: true)
            }
            
            else if self.buttonEnabled == 0 && self.getWinner() == "" && self.fPlayer == true {
                
                ref.child("Players").child("\(MainViewController.user.id)").child("invitatoDa").setValue("")
                ref.child("Players").child("\(MainViewController.user.id)").child("invitoAccettato").setValue("")
                ref.child("Players").child("\(MainViewController.user.id)").child("stato").setValue("online")
                
                ref.child("\(self.nomeTabella)").removeAllObservers()
                ref.child("Utility\(self.nomeTabella)").removeAllObservers()
                ref.child("Messages\(self.nomeTabella)").removeAllObservers()
                
                let alert = UIAlertController(title: "Pareggio", message: "", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.partitaFinita = true
                }))
                
                self.present(alert, animated: true)
            }
        }
        ref.child("\(nomeTabella)").observe(.value) { (snap) in
            
            let celle = snap.value as! [String : Any]
            
            for(key, value) in celle {
                
                let x = Int(String(key.first as! Character)) as! Int
                let y = Int(String(key.last as! Character)) as! Int
                
                let dati = value as! [String : String]
                
                let toccata = ConvertOptionalString.convert(dati["toccata"]!)
                let daChi = ConvertOptionalString.convert(dati["daChi"]!)
                
                if toccata == "Si" {
                    if daChi == MainViewController.user.nickName && self.fPlayer == true {
                        self.matrice[x][y] = "x"
                        self.buttons2D[x][y].setImage(self.myImage, for: .normal)
                    }
                    else if daChi == MainViewController.user.nickName && self.sPlayer == true {
                        self.matrice[x][y] = "o"
                        self.buttons2D[x][y].setImage(self.myImage, for: .normal)
                    }
                    else if daChi != MainViewController.user.nickName && self.fPlayer == true {
                        self.matrice[x][y] = "o"
                        self.buttons2D[x][y].setImage(self.oppositeImage, for: .normal)
                    }
                    else if daChi != MainViewController.user.nickName && self.sPlayer == true {
                        self.matrice[x][y] = "x"
                        self.buttons2D[x][y].setImage(self.oppositeImage, for: .normal)
                    }
                    
                    let winner = self.getWinner()
                    
                    if winner == "Hai vinto" {
                        
                        ref.child("Players").child("\(MainViewController.user.id)").child("vittorieTris").setValue("\(MainViewController.user.vittorieTris + 1)")
                        
                        ref.child("Players").child("\(MainViewController.user.id)").child("invitatoDa").setValue("")
                        ref.child("Players").child("\(MainViewController.user.id)").child("invitoAccettato").setValue("")
                        ref.child("Players").child("\(MainViewController.user.id)").child("stato").setValue("online")
                        
                        ref.child("\(self.nomeTabella)").removeAllObservers()
                        ref.child("Utility\(self.nomeTabella)").removeAllObservers()
                        ref.child("Messages\(self.nomeTabella)").removeAllObservers()
                        
                        let alert = UIAlertController(title: "Hai vinto", message: "Complimenti", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            self.partitaFinita = true
                        }))
                        
                        self.present(alert, animated: true)
                        
                        
                    }
                    else if winner == "Hai perso" {
                        
                        ref.child("Players").child("\(MainViewController.user.id)").child("sconfitteTris").setValue("\(MainViewController.user.sconfitteTris + 1)")
                        ref.child("Players").child("\(MainViewController.user.id)").child("invitatoDa").setValue("")
                        ref.child("Players").child("\(MainViewController.user.id)").child("invitoAccettato").setValue("")
                        ref.child("Players").child("\(MainViewController.user.id)").child("stato").setValue("online")
                        
                        ref.child("\(self.nomeTabella)").removeAllObservers()
                        ref.child("Utility\(self.nomeTabella)").removeAllObservers()
                        ref.child("Messages\(self.nomeTabella)").removeAllObservers()
                        
                        ref.child("\(self.nomeTabella)").removeValue()
                        ref.child("Utility\(self.nomeTabella)").removeValue()
                        ref.child("Messages\(self.nomeTabella)").removeValue()
                        
                        self.rivincita()
                    }
                }
            }
        }
        
    }
    
    
    @IBAction func mossa(_ sender: UIButton) {
        
        let x = Int(String(sender.titleLabel?.text?.first as! Character)) as! Int
        let y = Int(String(sender.titleLabel?.text?.last as! Character)) as! Int
        
        if fPlayer == true {
            if buttonEnabled%2 != 0 && self.matrice[x][y] == "" {
                
                self.matrice[x][y] = "x"
                
                let ref = Database.database().reference()
                ref.child("\(nomeTabella)").child("\(ConvertOptionalString.convert(sender.titleLabel?.text!))").setValue(["daChi":"\(MainViewController.user.nickName)","toccata":"Si"])
                ref.child("Utility\(nomeTabella)").child("buttonEnabled").setValue("\(buttonEnabled - 1)")
            }
        }
        else if sPlayer == true && self.matrice[x][y] == ""{
            if buttonEnabled%2 == 0 {
                
                self.matrice[x][y] = "o"
                
                let ref = Database.database().reference()
                ref.child("\(nomeTabella)").child("\(ConvertOptionalString.convert(sender.titleLabel?.text!))").setValue(["daChi":"\(MainViewController.user.nickName)","toccata":"Si"])
                ref.child("Utility\(nomeTabella)").child("buttonEnabled").setValue("\(buttonEnabled - 1)")
            }
        }
    }
    
   
    func getWinner() -> String
    {
        
        var k = 0;
        var h = 0;
        // Verifico se il tris è presente in una riga
        for i in 0...2
        {
            for j in 0...2
            {
                if matrice[i][j] != nil && matrice[i][j] == "x"
                {
                    k += 1
                    if(k==3){
                        if fPlayer == true {
                            return "Hai vinto"
                        }
                        else {
                            return "Hai perso"
                        }
                    }
                }
                else
                {
                    if matrice[i][j] != nil && matrice[i][j] == "o"
                    {
                        h += 1;
                        if(h==3){
                            if fPlayer == true {
                                return "Hai perso"
                            }
                            else {
                                return "Hai vinto"
                            }
                        }
                    }
                }
            }
            k=0
            h=0
        }
        // Verifico se il tris è presente in una colonna
        for i in 0...2
        {
            for j in 0...2
            {
                if matrice[j][i] != nil && matrice[j][i] == "x"
                {
                    k += 1
                    if(k==3){
                        if fPlayer == true {
                            return "Hai vinto"
                        }
                        else {
                            return "Hai perso"
                        }
                    }
                }
                else
                {
                    if matrice[j][i] != nil && matrice[j][i] == "o"
                    {
                        h += 1;
                        if(h==3){
                            if fPlayer == true {
                                return "Hai perso"
                            }
                            else {
                                return "Hai vinto"
                            }
                        }
                    }
                }
            }
            k=0
            h=0
        }
        
        // Verifico se il tris è presente in una diagonale
        for i in 0...2
        {
            let j = i;
            if matrice[i][j] != nil && matrice[i][j] == "x"
            {
                k += 1;
                if(k==3){
                    if fPlayer == true {
                        return "Hai vinto"
                    }
                    else {
                        return "Hai perso"
                    }
                }
            }
            else
            {
                if matrice[i][j] != nil && matrice[i][j] == "o"
                {
                    h += 1
                    if(h==3){
                        if fPlayer == true {
                            return "Hai perso"
                        }
                        else {
                            return "Hai vinto"
                        }
                    }
                }
            }
        }
        
        k=0
        h=0
        var j = 2
        
        for i in 0...2
        {
            if matrice[i][j] != nil && matrice[i][j] == "x"
            {
                k += 1;
                if(k==3){
                    if fPlayer == true {
                        return "Hai vinto"
                    }
                    else {
                        return "Hai perso"
                    }
                }
            }
            else
            {
                if matrice[i][j] != nil && matrice[i][j] == "o"
                {
                    h += 1;
                    if(h==3){
                        if fPlayer == true {
                            return "Hai perso"
                        }
                        else {
                            return "Hai vinto"
                        }
                    }
                }
            }
            j -= 1
        }
        return ""
    }
    
    func rivincita() {
        
        let alert = UIAlertController(title: "Hai perso", message: "Vuoi la rivincita con \(self.enemy.nickName)?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            let ref = Database.database().reference()
            
            ref.child("Players").child("\(self.enemy.id)").child("invitatoDa").setValue("\(MainViewController.user.nickName)\(LobbyViewController.gameSelected)")
            
            self.partitaFinita = true
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
            
            self.partitaFinita = true
        }))
        
        self.present(alert, animated: true)
    }
}
