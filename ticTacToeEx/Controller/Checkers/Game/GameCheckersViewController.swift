//
//  GameCheckersViewController.swift
//  ticTacToeEx
//
//  Created by CertimeterGroup on 17/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit
import Firebase

class GameCheckersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
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
        damieraImage.alpha = 0.3
        damieraStackView.alpha = 0.3
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
        damieraImage.alpha = 1
        damieraStackView.alpha = 1
        for i in buttons{
            i.isEnabled = true
        }
        
        chatButton.isHidden = false
        xButton.isHidden = true
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    
    // ------------------------ CHECKERS

    
    @IBOutlet weak var xButton: UIButton!
    
    @IBOutlet weak var chatButton: UIButton!
    
     @IBOutlet weak var chatView: UIView!
    
    @IBOutlet var buttons: [UIButton]!
    
    enum Error {
        case impossible, mangiataObbligatoria, turnoAvversario
    }
    
    var partitaFinita = false {
        didSet {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    var buttons2D: [[UIButton]]!
    
    var fPlayer = false
    var sPlayer = false
    
    var mioTurno: Bool = false
    
    var enemy = User()
    
    var myImage: UIImage!
    
    var enemyImage: UIImage!
    
    var myImageDama: UIImage!
    
    var enemyImageDama: UIImage!
    
    var nomeTabella = ""
    
    var caselleOccupabili: [String] = []
    
    var cellaToccata: String!
    
    var primoTocco: Bool = true
    
    var cellsMustEat: [String : [String]] = [:]
    
    
    // Grafica
    @IBOutlet weak var damieraImage: UIImageView!
    
    

    
    
    @IBOutlet weak var damieraStackView: UIStackView!
    // end
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if fPlayer == true {
            myImage = UIImage(named: "pedinaBianca")
            myImageDama = UIImage(named: "damaBianca")
            
            enemyImage = UIImage(named: "pedinaRossa")
            enemyImageDama = UIImage(named: "damaRossa")
        }
        else if sPlayer == true {
            myImage = UIImage(named: "pedinaRossa")
            myImageDama = UIImage(named: "damaRossa")
            
            enemyImage = UIImage(named: "pedinaBianca")
            enemyImageDama = UIImage(named: "damaBianca")
        }
        
        self.setNomeTabella()
        
        buttons2D = Utils.collectionToArray2D(arr: buttons, size: 8)
        
        self.popolaTabellaIniziale()
        
        self.creaTabellaDB()
        
        let ref = Database.database().reference()
        
        ref.child("Utility\(nomeTabella)").observe(.value, with: { (snap) in
            
            let dict = snap.value as! [String : Any]
            
            let turno = dict["TurnoDi"] as! String
            
            if (turno == "PrimoGiocatore" && self.fPlayer == true) || (turno == "SecondoGiocatore" && self.sPlayer == true)  {
                
                self.mioTurno = true
                for button in self.buttons {
                    if button.backgroundImage(for: .normal) == self.myImage || button.backgroundImage(for: .normal) == self.myImageDama {
                        self.mangiateObbligatorie(button)
                    }
                }
            }
            else {
                self.mioTurno = false
            }
        })
        
        ref.child("\(MainViewController.user.nickName)Damiera").child("Mossa").observe(.value, with: { (snap) in
            
            let dict = snap.value as! [String : String]
            
            if dict["GiocoIniziato"] == "Ok"{
                return
            }
            
            for (key, value) in dict {
                
                if value != "" {
                    
                    let x = Int(String((key.first)!))!
                    let y = Int(String((key.last)!))!
                    
                    if value.range(of: "Dama") != nil {
                        self.buttons2D[x][y].setBackgroundImage(self.enemyImageDama, for: .normal)
                    }
                    else {
                        self.buttons2D[x][y].setBackgroundImage(self.enemyImage, for: .normal)
                    }
                }
                else {
                    
                    let x = Int(String((key.first)!))!
                    let y = Int(String((key.last)!))!
                    
                    self.buttons2D[x][y].setBackgroundImage(nil, for: .normal)
                }
            }
            self.getWinner()
        })
        
        
        
        // set image damiera
        damieraImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: damieraImage, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: damieraImage, attribute: .top, relatedBy: .equal, toItem: dismissButton, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 6).isActive = true
        
        NSLayoutConstraint(item: damieraImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width / 100) * 78).isActive = true
        
        NSLayoutConstraint(item: damieraImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width / 100) * 78).isActive = true
        
        damieraImage.image = UIImage(named: "damiera")
        
        damieraImage.contentMode = .scaleAspectFill
        
        view.sendSubview(toBack: damieraImage)
        
        //Stack view contraints
        damieraStackView.translatesAutoresizingMaskIntoConstraints = false
        
        damieraStackView.distribution = .fillEqually
        
        NSLayoutConstraint(item: damieraStackView, attribute: .top, relatedBy: .equal, toItem: damieraImage, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: damieraStackView, attribute: .bottom, relatedBy: .equal, toItem: damieraImage, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: damieraStackView, attribute: .left, relatedBy: .equal, toItem: damieraImage, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: damieraStackView, attribute: .right, relatedBy: .equal, toItem: damieraImage, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        //background
        let background: UIImageView!
        background = UIImageView(frame: view.bounds)
        background.contentMode = .scaleAspectFill
        background.clipsToBounds = true
        background.image = UIImage(named: "woodBack")
        background.center = view.center
        
        view.addSubview(background)
        view.sendSubview(toBack: background)
        
        // TASTO ABBANDONA
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
        //        dismissButton.layer.borderWidth = 0.5
        //        dismissButton.layer.borderColor = UIColor.white.cgColor
        
        
        //top
        NSLayoutConstraint(item: dismissButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 15).isActive = true
        //right
        NSLayoutConstraint(item: dismissButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        //width
        NSLayoutConstraint(item: dismissButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 4).isActive = true
        //height
        NSLayoutConstraint(item: dismissButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        
        dismissButton.setTitle("Quit", for: .normal)
        dismissButton.setTitleColor(UIColor.white, for: .normal)
        //        dismissButton.titleLabel?.font = UIFont(name: "raleway", size: UIScreen.main.bounds.width)
        
        dismissButton.titleLabel?.adjustsFontSizeToFitWidth = true
        dismissButton.titleLabel?.baselineAdjustment = .alignCenters
        dismissButton.titleLabel?.textAlignment = .center
        
        
        //Chat Button
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        
        //        chatButton.layer.borderWidth = 0.5
        //        chatButton.layer.borderColor = UIColor.white.cgColor
        
        //top
        NSLayoutConstraint(item: chatButton, attribute: .top, relatedBy: .equal, toItem: damieraImage, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 10).isActive = true
        
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
        
        
        xButton.translatesAutoresizingMaskIntoConstraints = false
        
        //        xButton.layer.borderWidth = 0.5
        //        xButton.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint(item: xButton, attribute: .top, relatedBy: .equal, toItem: chatView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: xButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        //
        
        
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
        
        
        
        let center = NotificationCenter.default
        
        center.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.textFieldMessage.delegate = self
        self.chatTable.delegate = self
        self.chatTable.dataSource = self
        
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
        
        
        
        
    }

    func setNomeTabella() {
        
        if fPlayer == true && sPlayer == false {
            
            self.nomeTabella = "\(MainViewController.user.nickName)VS\(self.enemy.nickName)Damiera"
        }
        else if fPlayer == false && sPlayer == true {
            
            self.nomeTabella = "\(self.enemy.nickName)VS\(MainViewController.user.nickName)Damiera"
        }
    }
    
    func popolaTabellaIniziale() {
        
        for x in 5...7 {
            
            if x%2 != 0 {
                for y in 0...7 {
                    if y%2 != 0 {
                        buttons2D[x][y].setBackgroundImage(self.myImage, for: .normal)
                        buttons2D[x][y].setBackgroundImage(self.myImage, for: .disabled)
                    }
                }
            }
            else {
                for y in 0...7 {
                    if y%2 == 0 {
                        buttons2D[x][y].setBackgroundImage(self.myImage, for: .normal)
                        buttons2D[x][y].setBackgroundImage(self.myImage, for: .disabled)
                    }
                }
            }
        }
        
        for x in 0...2 {
            
            if x%2 != 0 {
                for y in 0...7 {
                    if y%2 != 0 {
                        buttons2D[x][y].setBackgroundImage(self.enemyImage, for: .normal)
                        buttons2D[x][y].setBackgroundImage(self.enemyImage, for: .disabled)
                    }
                }
            }
            else {
                for y in 0...7 {
                    if y%2 == 0{
                        buttons2D[x][y].setBackgroundImage(self.enemyImage, for: .normal)
                        buttons2D[x][y].setBackgroundImage(self.enemyImage, for: .disabled)
                    }
                }
            }
        }
        
    }
    
    func creaTabellaDB() {
        
        let ref = Database.database().reference()
        
        ref.child("\(MainViewController.user.nickName)Damiera").child("Mossa").child("GiocoIniziato").setValue("Ok")
        
        ref.child("Utility\(self.nomeTabella)").child("TurnoDi").setValue("PrimoGiocatore")
    }
    
    func mangiateObbligatorie(_ casella: UIButton) {
        
        let x = Int(String((casella.titleLabel?.text?.first)!))!
        let y = Int(String((casella.titleLabel?.text?.last)!))!
        
        if casella.backgroundImage(for: .normal) == self.myImage {
            
            self.mangiateObbligatoriePedina(casella, x, y)
        }
            
        else if casella.backgroundImage(for: .normal) == self.myImageDama {
            
            self.mangiateObbligatorieDama(casella, x, y)
        }
    }
    
    func mangiateObbligatoriePedina(_ casella: UIButton, _ x: Int, _ y: Int) {
        
        if x - 2 >= 0 && y - 2 >= 0 && y + 2 <= 7 {
            
            var tmpFinalCells: [String] = []
            
            if (buttons2D[x - 1][y + 1].backgroundImage(for: .normal) == enemyImage || buttons2D[x - 1][y + 1].backgroundImage(for: .normal) == enemyImageDama) &&  buttons2D[x - 2][y + 2].backgroundImage(for: .normal) == nil{
                
                tmpFinalCells.append(buttons2D[x - 2][y + 2].titleLabel?.text as! String)
            }
            if (buttons2D[x - 1][y - 1].backgroundImage(for: .normal) == enemyImage || buttons2D[x - 1][y - 1].backgroundImage(for: .normal) == enemyImageDama) &&  buttons2D[x - 2][y - 2].backgroundImage(for: .normal) == nil{
                
                tmpFinalCells.append(buttons2D[x - 2][y - 2].titleLabel?.text as! String)
            }
            if tmpFinalCells.isEmpty == false {
                self.cellsMustEat.updateValue(tmpFinalCells, forKey: casella.titleLabel?.text as! String)
            }
        }
        if x - 2 >= 0 && y - 2 <= 0 && y + 2 <= 7 {
            
            var tmpFinalCells: [String] = []
            
            if (buttons2D[x - 1][y + 1].backgroundImage(for: .normal) == enemyImage || buttons2D[x - 1][y + 1].backgroundImage(for: .normal) == enemyImageDama) &&  buttons2D[x - 2][y + 2].backgroundImage(for: .normal) == nil{
                
                tmpFinalCells.append(buttons2D[x - 2][y + 2].titleLabel?.text as! String)
            }
            
            if tmpFinalCells.isEmpty == false {
                self.cellsMustEat.updateValue(tmpFinalCells, forKey: casella.titleLabel?.text as! String)
            }
        }
        if x - 2 >= 0 && y - 2 >= 0 && y + 2 >= 7 {
            
            var tmpFinalCells: [String] = []
            
            if (buttons2D[x - 1][y - 1].backgroundImage(for: .normal) == enemyImage || buttons2D[x - 1][y - 1].backgroundImage(for: .normal) == enemyImageDama) &&  buttons2D[x - 2][y - 2].backgroundImage(for: .normal) == nil{
                
                tmpFinalCells.append(buttons2D[x - 2][y - 2].titleLabel?.text as! String)
            }
            if tmpFinalCells.isEmpty == false {
                self.cellsMustEat.updateValue(tmpFinalCells, forKey: casella.titleLabel?.text as! String)
            }
        }
    }
    
    func mangiateObbligatorieDama(_ casella: UIButton,_ x: Int,_ y: Int) {
        
        if x - 2 >= 0 && y - 2 >= 0 && y + 2 <= 7 {
            
            var tmpFinalCells: [String] = []
            
            if (buttons2D[x - 1][y + 1].backgroundImage(for: .normal) == enemyImage || buttons2D[x - 1][y + 1].backgroundImage(for: .normal) == enemyImageDama) &&  buttons2D[x - 2][y + 2].backgroundImage(for: .normal) == nil{
                
                tmpFinalCells.append(buttons2D[x - 2][y + 2].titleLabel?.text as! String)
            }
            if (buttons2D[x - 1][y - 1].backgroundImage(for: .normal) == enemyImage || buttons2D[x - 1][y - 1].backgroundImage(for: .normal) == enemyImage) &&  buttons2D[x - 2][y - 2].backgroundImage(for: .normal) == nil{
                
                tmpFinalCells.append(buttons2D[x - 2][y - 2].titleLabel?.text as! String)
            }
            if tmpFinalCells.isEmpty == false {
                self.cellsMustEat.updateValue(tmpFinalCells, forKey: casella.titleLabel?.text as! String)
            }
        }
        if x - 2 >= 0 && y - 2 <= 0 && y + 2 <= 7 {
            
            var tmpFinalCells: [String] = []
            
            if (buttons2D[x - 1][y + 1].backgroundImage(for: .normal) == enemyImage || buttons2D[x - 1][y + 1].backgroundImage(for: .normal) == enemyImageDama) &&  buttons2D[x - 2][y + 2].backgroundImage(for: .normal) == nil{
                
                tmpFinalCells.append(buttons2D[x - 2][y + 2].titleLabel?.text as! String)
            }
            
            if tmpFinalCells.isEmpty == false {
                self.cellsMustEat.updateValue(tmpFinalCells, forKey: casella.titleLabel?.text as! String)
            }
        }
        if x - 2 >= 0 && y - 2 >= 0 && y + 2 >= 7 {
            
            var tmpFinalCells: [String] = []
            
            if (buttons2D[x - 1][y - 1].backgroundImage(for: .normal) == enemyImage || buttons2D[x - 1][y - 1].backgroundImage(for: .normal) == enemyImage) &&  buttons2D[x - 2][y - 2].backgroundImage(for: .normal) == nil{
                
                tmpFinalCells.append(buttons2D[x - 2][y - 2].titleLabel?.text as! String)
            }
            if tmpFinalCells.isEmpty == false {
                self.cellsMustEat.updateValue(tmpFinalCells, forKey: casella.titleLabel?.text as! String)
            }
        }
        if x + 2 <= 7 && y - 2 >= 0 && y + 2 <= 7 {
            
            var tmpFinalCells: [String] = []
            
            if (buttons2D[x + 1][y + 1].backgroundImage(for: .normal) == enemyImage || buttons2D[x + 1][y + 1].backgroundImage(for: .normal) == enemyImageDama) &&  buttons2D[x + 2][y + 2].backgroundImage(for: .normal) == nil{
                
                tmpFinalCells.append(buttons2D[x + 2][y + 2].titleLabel?.text as! String)
            }
            if (buttons2D[x + 1][y - 1].backgroundImage(for: .normal) == enemyImage || buttons2D[x + 1][y - 1].backgroundImage(for: .normal) == enemyImageDama) && buttons2D[x + 2][y - 2].backgroundImage(for: .normal) == nil{
                
                tmpFinalCells.append(buttons2D[x + 2][y - 2].titleLabel?.text as! String)
            }
            if tmpFinalCells.isEmpty == false {
                self.cellsMustEat.updateValue(tmpFinalCells, forKey: casella.titleLabel?.text as! String)
            }
        }
            
        if x + 2 >= 0 && y - 2 <= 0 && y + 2 <= 7 {
            
            var tmpFinalCells: [String] = []
            
            if (buttons2D[x + 1][y + 1].backgroundImage(for: .normal) == enemyImage || buttons2D[x + 1][y + 1].backgroundImage(for: .normal) == enemyImageDama) &&  buttons2D[x + 2][y + 2].backgroundImage(for: .normal) == nil{
                
                tmpFinalCells.append(buttons2D[x + 2][y + 2].titleLabel?.text as! String)
            }
            
            if tmpFinalCells.isEmpty == false {
                self.cellsMustEat.updateValue(tmpFinalCells, forKey: casella.titleLabel?.text as! String)
            }
        }
            
        if x + 2 >= 0 && y - 2 >= 0 && y + 2 >= 7 {
            
            var tmpFinalCells: [String] = []
            
            if (buttons2D[x + 1][y - 1].backgroundImage(for: .normal) == enemyImage || buttons2D[x + 1][y - 1].backgroundImage(for: .normal) == enemyImageDama) &&  buttons2D[x + 2][y - 2].backgroundImage(for: .normal) == nil{
                
                tmpFinalCells.append(buttons2D[x + 2][y - 2].titleLabel?.text as! String)
            }
            if tmpFinalCells.isEmpty == false {
                self.cellsMustEat.updateValue(tmpFinalCells, forKey: casella.titleLabel?.text as! String)
            }
        }
    }
    
    func ribaltoMossa(_ mossa: String) -> String {
        
        let x = Int(String(mossa.first!))!
        let y = Int(String(mossa.last!))!
        
        let newX = 7 - x
        let newY = 7 - y
        
        let newString = "\(newX):\(newY)"
        
        return newString
        
    }
    
    func impostaTurno() {
        
        let ref = Database.database().reference()
        
        if fPlayer == true {
            ref.child("Utility\(self.nomeTabella)").child("TurnoDi").setValue("SecondoGiocatore")
        }
        else if sPlayer == true {
            ref.child("Utility\(self.nomeTabella)").child("TurnoDi").setValue("PrimoGiocatore")
        }
    }
    
    
    
    @IBAction func mossa(_ sender: UIButton) {
        
        if self.mioTurno == true {
            
            if self.cellsMustEat.isEmpty == false && primoTocco == true {
                
                self.cellaToccata = sender.titleLabel?.text as! String
                
                for(key, value) in self.cellsMustEat {
                    
                    if key == sender.titleLabel?.text as! String {
                        
                        self.caselleOccupabili = value
                        
                        self.primoTocco = false
                    }
                }
            }
                
            else if self.cellsMustEat.isEmpty == false && primoTocco == false {
                
                if self.caselleOccupabili.contains(sender.titleLabel?.text as! String) {
                    
                    if Int(String((sender.titleLabel?.text?.first!)!))! == 0 || buttons2D[Int(String(self.cellaToccata.first!))!][Int(String(self.cellaToccata.last!))!].backgroundImage(for: .normal) == self.myImageDama {
                        
                        sender.setBackgroundImage(self.myImageDama, for: .normal)
                    }
                    else {
                        sender.setBackgroundImage(self.myImage, for: .normal)
                    }
                    
                    var yMangiata = 0
                    var xMangiata = 0
                    
                    if Int(String(self.cellaToccata.last!))! < Int(String((sender.titleLabel?.text?.last)!))! {
                        
                        yMangiata = Int(String(self.cellaToccata.last!))! + 1
                    }
                    else {
                        yMangiata = Int(String(self.cellaToccata.last!))! - 1
                    }
                    
                    if Int(String(self.cellaToccata.first!))! < Int(String((sender.titleLabel?.text?.first)!))! {
                        
                        xMangiata = Int(String(self.cellaToccata.first!))! + 1
                    }
                    else {
                        
                        xMangiata = Int(String(self.cellaToccata.first!))! - 1
                    }
                    
                    buttons2D[xMangiata][yMangiata].setBackgroundImage(nil, for: .normal)
                    
                    self.caselleOccupabili.removeAll()
                    
                    self.cellsMustEat.removeAll()
                    
                    let cellaTocRib = self.ribaltoMossa(self.cellaToccata)
                    let cellEated = self.ribaltoMossa("\(xMangiata):\(yMangiata)")
                    let senderTitleRib = self.ribaltoMossa(sender.titleLabel?.text as! String)
                    
                    let ref = Database.database().reference()
                    
                    var mossa: [String : String] = [:]
                    
                    if buttons2D[Int(String(self.cellaToccata.first!))!][Int(String(self.cellaToccata.last!))!].backgroundImage(for: .normal) == self.myImageDama || Int(String((sender.titleLabel?.text?.first!)!))! == 0 {
                        
                        mossa = [
                            "\(cellaTocRib)" : "",
                            "\(cellEated)" : "",
                            "\(senderTitleRib)" : "\(MainViewController.user.nickName):Dama"
                        ]
                    }
                        
                    else {
                        mossa = [
                            "\(cellaTocRib)" : "",
                            "\(cellEated)" : "",
                            "\(senderTitleRib)" : "\(MainViewController.user.nickName)"
                        ]
                    }
                    
                    buttons2D[Int(String(self.cellaToccata.first!))!][Int(String(self.cellaToccata.last!))!].setBackgroundImage(nil, for: .normal)
                    
                    self.cellaToccata = ""
                    
                    self.getWinner()
                    
                    ref.child("\(self.enemy.nickName)Damiera").child("Mossa").setValue(mossa)
                    
                    self.mangiateObbligatorie(sender)
                    
                    if cellsMustEat.isEmpty == true {
                        self.impostaTurno()
                    }
                }
                else {
                    
                    self.segnaliErrori(.impossible)
                }
                self.primoTocco = true
            }
                
            else {
                
                if primoTocco == true {
                    
                    self.cellaToccata = sender.titleLabel?.text as! String
                    
                    let x = Int(String((sender.titleLabel?.text?.first)!))!
                    let y = Int(String((sender.titleLabel?.text?.last)!))!
                    
                    if sender.backgroundImage(for: .normal) == self.myImage {
                        
                        if x > 0 && y + 1 <= 7 {
                            if buttons2D[x - 1][y + 1].backgroundImage(for: .normal) == nil && y + 1 <= 7 {
                                self.caselleOccupabili.append(buttons2D[x - 1][y + 1].titleLabel?.text as! String)
                            }
                        }
                        if x > 0 && y - 1 >= 0 {
                            if buttons2D[x - 1][y - 1].backgroundImage(for: .normal) == nil {
                                self.caselleOccupabili.append(buttons2D[x - 1][y - 1].titleLabel?.text as! String)
                            }
                        }
                    }
                        
                    else if sender.backgroundImage(for: .normal) == self.myImageDama {
                        
                        if x > 0 && y + 1 <= 7 {
                            if buttons2D[x - 1][y + 1].backgroundImage(for: .normal) == nil {
                                self.caselleOccupabili.append(buttons2D[x - 1][y + 1].titleLabel?.text as! String)
                            }
                        }
                        if x > 0 && y - 1 >= 0 {
                            if buttons2D[x - 1][y - 1].backgroundImage(for: .normal) == nil {
                                self.caselleOccupabili.append(buttons2D[x - 1][y - 1].titleLabel?.text as! String)
                            }
                        }
                        if x < 7 && y + 1 <= 7 {
                            if buttons2D[x + 1][y + 1].backgroundImage(for: .normal) == nil {
                                self.caselleOccupabili.append(buttons2D[x + 1][y + 1].titleLabel?.text as! String)
                            }
                        }
                        if x < 7 && y - 1 >= 0 {
                            if buttons2D[x + 1][y - 1].backgroundImage(for: .normal) == nil {
                                self.caselleOccupabili.append(buttons2D[x + 1][y - 1].titleLabel?.text as! String)
                            }
                        }
                        
                    }
                    self.primoTocco = false
                }
                else {
                    
                    if self.caselleOccupabili.contains(sender.titleLabel?.text as! String) {
                        
                        if Int(String((sender.titleLabel?.text?.first!)!))! == 0 ||  buttons2D[Int(String(self.cellaToccata.first!))!][Int(String(self.cellaToccata.last!))!].backgroundImage(for: .normal) == self.myImageDama {
                            
                            sender.setBackgroundImage(self.myImageDama, for: .normal)
                        }
                        else {
                            sender.setBackgroundImage(self.myImage, for: .normal)
                        }
                        
                        self.caselleOccupabili.removeAll()
                        
                        let ref = Database.database().reference()
                        
                        let cellaTocRib = self.ribaltoMossa(self.cellaToccata)
                        let senderTitleRib = self.ribaltoMossa(sender.titleLabel?.text as! String)
                        
                        var mossa: [String : String] = [:]
                        
                        if buttons2D[Int(String(self.cellaToccata.first!))!][Int(String(self.cellaToccata.last!))!].backgroundImage(for: .normal) == self.myImageDama || Int(String((sender.titleLabel?.text?.first!)!))! == 0 {
                            
                            mossa = [
                                "\(cellaTocRib)" : "",
                                "\(senderTitleRib)" : "\(MainViewController.user.nickName):Dama"
                            ]
                        }
                            
                        else {
                            
                            mossa = [
                                "\(cellaTocRib)" : "",
                                "\(senderTitleRib)" : "\(MainViewController.user.nickName)"
                            ]
                            
                        }
                        
                        buttons2D[Int(String(self.cellaToccata.first!))!][Int(String(self.cellaToccata.last!))!].setBackgroundImage(nil, for: .normal)
                        
                        self.cellaToccata = ""
                        
                        self.getWinner()
                        
                        ref.child("\(self.enemy.nickName)Damiera").child("Mossa").setValue(mossa)
                        
                        self.impostaTurno()
                    }
                    else{
                        self.segnaliErrori(.impossible)
                    }
                    self.primoTocco = true
                }
            }
        }
        else {
            
            self.segnaliErrori(.turnoAvversario)
        }
    }
    func getWinner() {
        
        var myCount = 0
        var enemyCount = 0
        
        let ref = Database.database().reference()
        
        for button in buttons {
            if button.backgroundImage(for: .normal) == self.myImage || button.backgroundImage(for: .normal) == self.myImageDama {
                myCount += 1
            }
            else if button.backgroundImage(for: .normal) == self.enemyImage || button.backgroundImage(for: .normal) == self.enemyImageDama {
                enemyCount += 1
            }
        }
        
        if enemyCount == 0 {
            
            ref.child("Players").child("\(MainViewController.user.id)").child("vittorieDama").setValue("\(MainViewController.user.vittorieDama + 1)")
            
            ref.child("Players").child("\(MainViewController.user.id)").child("invitatoDa").setValue("")
            ref.child("Players").child("\(MainViewController.user.id)").child("invitoAccettato").setValue("")
            ref.child("Players").child("\(MainViewController.user.id)").child("stato").setValue("online")
            
            ref.child("\(MainViewController.user.nickName)Damiera").child("Mossa").removeAllObservers()
            ref.child("\(MainViewController.user.nickName)Damiera").removeValue()
            ref.child("Utility\(self.nomeTabella)").removeAllObservers()
            
            
            let alert = UIAlertController(title: "Hai vinto", message: "Bravo", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                self.partitaFinita = true
            }))
            
            self.present(alert, animated: true)
        }
        else if myCount == 0 {
            
            ref.child("Players").child("\(MainViewController.user.id)").child("sconfitteDama").setValue("\(MainViewController.user.sconfitteDama + 1)")
            
            ref.child("Players").child("\(MainViewController.user.id)").child("invitatoDa").setValue("")
            ref.child("Players").child("\(MainViewController.user.id)").child("invitoAccettato").setValue("")
            ref.child("Players").child("\(MainViewController.user.id)").child("stato").setValue("online")
            
            ref.child("\(MainViewController.user.nickName)Damiera").child("Mossa").removeAllObservers()
            ref.child("\(MainViewController.user.nickName)Damiera").removeValue()
            ref.child("Utility\(self.nomeTabella)").removeAllObservers()
            ref.child("Utility\(self.nomeTabella)").removeValue()
            
            let alert = UIAlertController(title: "Hai perso", message: "Mi spiace", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                self.partitaFinita = true
            }))
            
            self.present(alert, animated: true)
        }
    }
    
    func segnaliErrori(_ error: Error) {
        
        switch error {
            
        case .turnoAvversario :
            
            let alert = UIAlertController(title: "Non è il tuo turno", message: "aspetta", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
            }))
            
            self.present(alert, animated: true)
            
        case .impossible:
            
            let alert = UIAlertController(title: "Mossa nn legale", message: "riprova", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
            }))
            
            self.present(alert, animated: true)
            
        case .mangiataObbligatoria:
            
            let alert = UIAlertController(title: "Mangiata obbligatoria", message: "Impossibile muovere la pedina selezionata", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
            }))
            
            self.present(alert, animated: true)
            
        }
    }

}
