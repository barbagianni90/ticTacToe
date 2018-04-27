//
//  LobbyViewController.swift
//  ticTacToeEx
//
//  Created by Mac Luca on 30/03/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit
import Firebase



class ActivityViewController: UIViewController {
    
    private let activityView = ActivityView()
    
    init(message: String) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        activityView.messageLabel.text = message
        view = activityView
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class ActivityView: UIView {
    
    let activityIndicatorView = UIActivityIndicatorView()
    let boundingBoxView = UIView()
    let messageLabel = UILabel()
    
    init() {
        
        super.init(frame: CGRect())
        
        backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        
        self.boundingBoxView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        self.boundingBoxView.layer.cornerRadius = 12.0
        
        activityIndicatorView.startAnimating()
        
        self.messageLabel.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        self.messageLabel.textColor = UIColor.white
        self.messageLabel.textAlignment = .center
        self.messageLabel.shadowColor = UIColor.black
        self.messageLabel.numberOfLines = 0
        
        addSubview(boundingBoxView)
        addSubview(activityIndicatorView)
        addSubview(messageLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        boundingBoxView.frame.size.width = 160.0
        boundingBoxView.frame.size.height = 160.0
        boundingBoxView.frame.origin.x = (bounds.width / 2.0) - (boundingBoxView.frame.width / 2.0)
        boundingBoxView.frame.origin.y = (bounds.height / 2.0) - (boundingBoxView.frame.height / 2.0)
        
        activityIndicatorView.frame.origin.x = ceil((bounds.width / 2.0) - (activityIndicatorView.frame.width / 2.0))
        activityIndicatorView.frame.origin.y = ceil((bounds.height / 2.0) - (activityIndicatorView.frame.height / 2.0))
        
        let messageLabelSize = messageLabel.sizeThatFits(CGSize(width: 160.0 - 20.0 * 2.0, height: CGFloat.greatestFiniteMagnitude))
        messageLabel.frame.size.width = messageLabelSize.width
        messageLabel.frame.size.height = messageLabelSize.height
        messageLabel.frame.origin.x = (bounds.width / 2.0) - (messageLabel.frame.width / 2.0)
        messageLabel.frame.origin.y = activityIndicatorView.frame.origin.y + activityIndicatorView.frame.size.height + ((boundingBoxView.frame.height - activityIndicatorView.frame.height) / 4.0) - (messageLabel.frame.height / 2.0)
    }
}

class LobbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var players: [User] = []
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var giocatoreLabel: UILabel!
    
    @IBOutlet weak var lobbyLabel: UILabel!
    @IBOutlet weak var statoLabel: UILabel!
    
    @IBOutlet weak var avatarButton: UIButton!
    
    @IBAction func avatarButton(_ sender: UIButton) {
        
        let profile = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "profileInfo")
        self.present(profile,animated: true,completion: nil)
        
    }
    
    
    let activitiyViewController = ActivityViewController(message: "Attending...")
    
    var sfidante: [String : String] = ["id" : "",
                                       "nickname" : ""]
    
    var statePlayerSelected: String = ""
    
    static var gameSelected: String = ""
    
    var selectedRow = -1
    
    @IBOutlet weak var lobbyTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lobbyTable.delegate = self
        self.lobbyTable.dataSource = self
        // Do any additional setup after loading the view.
        
        refresh()
        
        let refreshControl: UIRefreshControl = {
            
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:
                #selector(LobbyViewController.handleRefresh(_:)),
                                     for: UIControlEvents.valueChanged)
            refreshControl.tintColor = UIColor.red
            
            return refreshControl
        }()
        
        self.lobbyTable.addSubview(refreshControl)
        
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue:"MyNotification"), object: nil, queue: nil, using: invite)
        
        
        
        
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
        
        
        
        // home button
        
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
        
        
        // constraints avatar button
        
        avatarButton.translatesAutoresizingMaskIntoConstraints = false
        //                avatarButton.layer.borderWidth = 1
        //                avatarButton.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint(item: avatarButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 20).isActive = true
        
        NSLayoutConstraint(item: avatarButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: UIScreen.main.bounds.width / -15).isActive = true
        
        NSLayoutConstraint(item: avatarButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 8).isActive = true
        
        NSLayoutConstraint(item: avatarButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 8).isActive = true
        
        
        avatarButton.imageView?.contentMode = .scaleAspectFill
        avatarButton.imageView?.layer.cornerRadius = (UIScreen.main.bounds.width / 7) / 2
        
        
        if MainViewController.user.nickName == "" {
            self.avatarButton.isHidden = true
        }
        else{
            self.avatarButton.isHidden = false
            self.avatarButton.setBackgroundImage(MainViewController.user.image, for: .normal)
            self.avatarButton.layer.cornerRadius = (UIScreen.main.bounds.width / 8) / 2
            self.avatarButton.layer.masksToBounds = true
            self.avatarButton.backgroundColor = UIColor.clear
            self.avatarButton.imageView?.contentMode = .scaleAspectFill
            
        }
        
        
        
        
        
        
        
        
        // lobby label
        
        lobbyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //        rankingLabel.layer.borderColor = UIColor.white.cgColor
        //        rankingLabel.layer.borderWidth = 0.5
        
        NSLayoutConstraint(item: lobbyLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.size.height / 10).isActive = true
        
        NSLayoutConstraint(item: lobbyLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: lobbyLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 2).isActive = true
        
        NSLayoutConstraint(item: lobbyLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 6).isActive = true
        
        let attTitleLabel = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.height / 6)]
        
        let lobbyLabelText = "Lobby"
        let attLobby = NSMutableAttributedString(string: lobbyLabelText, attributes: attTitleLabel)
        
        lobbyLabel.attributedText = attLobby
        
        lobbyLabel.adjustsFontSizeToFitWidth = true
        lobbyLabel.baselineAdjustment = .alignCenters
        
        
        
        
        // giocatore label
        
        
        statoLabel.translatesAutoresizingMaskIntoConstraints = false
        
//                statoLabel.layer.borderColor = UIColor.white.cgColor
//                statoLabel.layer.borderWidth = 0.5
        
        NSLayoutConstraint(item: statoLabel, attribute: .top, relatedBy: .equal, toItem: lobbyLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 30).isActive = true
        
        NSLayoutConstraint(item: statoLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: UIScreen.main.bounds.size.width / -20).isActive = true
        
        
        NSLayoutConstraint(item: statoLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 4).isActive = true
        
        NSLayoutConstraint(item: statoLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 20).isActive = true
        
        
        
        let attStatoLabel = [NSAttributedStringKey.font: UIFont(name: "Roboto-Regular", size: UIScreen.main.bounds.height / 24)]
        
        let statoLabelText = "Status"
        let attStato = NSMutableAttributedString(string: statoLabelText, attributes: attStatoLabel)
        
        statoLabel.attributedText = attStato
        
        statoLabel.adjustsFontSizeToFitWidth = true
        statoLabel.baselineAdjustment = .alignCenters
        statoLabel.textAlignment = .right
        
        
        
        // giocatore label
        
        giocatoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
//                giocatoreLabel.layer.borderColor = UIColor.white.cgColor
//                giocatoreLabel.layer.borderWidth = 0.5
        
        NSLayoutConstraint(item: giocatoreLabel, attribute: .top, relatedBy: .equal, toItem: lobbyLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 30).isActive = true
        
        NSLayoutConstraint(item: giocatoreLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.size.width / 20).isActive = true
        
        
        NSLayoutConstraint(item: giocatoreLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 4).isActive = true
        
        NSLayoutConstraint(item: giocatoreLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 20).isActive = true
        
        
        
        let attGiocatoreLabel = [NSAttributedStringKey.font: UIFont(name: "Roboto-Regular", size: UIScreen.main.bounds.height / 24)]
        
        let giocatoreLabelText = "Player"
        let attGiocatore = NSMutableAttributedString(string: giocatoreLabelText, attributes: attGiocatoreLabel)
        
        giocatoreLabel.attributedText = attGiocatore
        
        giocatoreLabel.adjustsFontSizeToFitWidth = true
        giocatoreLabel.baselineAdjustment = .alignCenters
        giocatoreLabel.textAlignment = .left
        
        
        
        // lobby table
        
        lobbyTable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: lobbyTable, attribute: .top, relatedBy: .equal, toItem: statoLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 100).isActive = true
        
        NSLayoutConstraint(item: lobbyTable, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: lobbyTable, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width).isActive = true
        
        NSLayoutConstraint(item: lobbyTable, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
      
        
        
        
        
    }
    
    func invite(notification: Notification) {
        
        let ref = Database.database().reference()
        
        if self.statePlayerSelected == "online" {
            
            ref.child("Players").child("\(MainViewController.user.id)").child("stato").setValue("occupato")
            
            for user in players {
                
                if user.nickName == self.sfidante["nickname"]{
                    
                    ref.child("Players").child("\(user.id)").child("invitatoDa").setValue("\(MainViewController.user.nickName)\(LobbyViewController.gameSelected)")
                    
                    self.sfidante.updateValue(user.id, forKey: "id")
                }
            }
            
            self.present(activitiyViewController, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let ref = Database.database().reference()
        
        ref.child("Players").child("\(MainViewController.user.id)").child("invitatoDa").observe(.value) { (snap, error) in
            
            if error == nil {
            
                let value = snap.value as! String
                
                if value != "" {
                    
                    LobbyViewController.gameSelected = ConvertOptionalString.extractNameGame(value)
                    
                    let enemyNickName = ConvertOptionalString.extractNickname(value)
                    
                    ref.child("Players").child("\(MainViewController.user.id)").child("stato").setValue("occupato")
                    
                    var idNickInvito = ""
                    
                    for user in self.players {
                        
                        if user.nickName == enemyNickName {
                            
                            idNickInvito = user.id
                        }
                    }
                    
                    let alert = UIAlertController(title: "\(enemyNickName) ti ha invitato a giocare a \(LobbyViewController.gameSelected)", message: nil, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Accetto", style: .default, handler: { action in
                        
                        ref.child("Players").child("\(idNickInvito)").child("invitoAccettato").setValue("Si")
                        
                        if LobbyViewController.gameSelected == "tris" {
                            
                            let segue = UIStoryboard(name:"GameTris",bundle:nil).instantiateViewController(withIdentifier: "GameTrisID") as! GameTrisViewController
                            
                            let enemy = User()
                            enemy.id = idNickInvito
                            enemy.nickName = "\(enemyNickName)"
                            
                            for user in self.players {
                                
                                if user.nickName == enemyNickName {
                                    
                                    enemy.image = user.image
                                }
                            }
                            segue.enemy = enemy
                            
                            segue.fPlayer = false
                            segue.sPlayer = true
                            
                            self.present(segue, animated: true, completion: nil)
                        }
                        
                        if LobbyViewController.gameSelected == "dama" {
                            
                            let segue = UIStoryboard(name:"GameCheckers",bundle:nil).instantiateViewController(withIdentifier: "GameCheckID") as! GameCheckersViewController
                            
                            let enemy = User()
                            enemy.id = idNickInvito
                            enemy.nickName = "\(enemyNickName)"
                            
                            for user in self.players {
                                
                                if user.nickName == enemyNickName {
                                    
                                    enemy.image = user.image
                                }
                            }
                            segue.enemy = enemy
                            
                            segue.fPlayer = false
                            segue.sPlayer = true
                            
                            self.present(segue, animated: true, completion: nil)
                        }
                    }))
                    
                    alert.addAction(UIAlertAction(title: "Rifiuto", style: .default, handler: { action in
                        
                        ref.child("Players").child("\(idNickInvito)").child("invitoAccettato").setValue("No")
                        ref.child("Players").child("\(MainViewController.user.id)").child("invitatoDa").setValue("")
                        ref.child("Players").child("\(MainViewController.user.id)").child("stato").setValue("online")
                    }))
                    
                    self.present(alert, animated: true)
                }
            }
            else {
                
                ref.child("Players").child("\(MainViewController.user.id)").child("invitatoDa").setValue("")
                ref.child("Players").child("\(MainViewController.user.id)").child("InvitoAccettato").setValue("")
                ref.child("Players").child("\(MainViewController.user.id)").child("loggato").setValue("No")
            }
        }
        
        ref.child("Players").child("\(MainViewController.user.id)").child("invitoAccettato").observe(.value) { (snap, error) in
            
            if error == nil {
            
            let value = snap.value as! String
            
                if value != "" {
                    
                    self.activitiyViewController.dismiss(animated: true, completion: nil)
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if value == "Si" {
                        
                        if LobbyViewController.gameSelected == "tris" {
                            
                            let segue = UIStoryboard(name:"GameTris",bundle:nil).instantiateViewController(withIdentifier: "GameTrisID") as! GameTrisViewController
                            
                            let enemy = User()
                            enemy.id = self.sfidante["id"]!
                            enemy.nickName = self.sfidante["nickname"]!
                            
                            for user in self.players {
                                
                                if user.nickName == self.sfidante["nickname"]! {
                                    
                                    enemy.image = user.image
                                }
                            }
                            segue.enemy = enemy
                            
                            segue.fPlayer = true
                            segue.sPlayer = false
                            
                            self.present(segue, animated: true, completion: nil)
                        }
                        
                        if LobbyViewController.gameSelected == "dama" {
                            
                            let segue = UIStoryboard(name:"GameCheckers",bundle:nil).instantiateViewController(withIdentifier: "GameCheckID") as! GameCheckersViewController
                            
                            let enemy = User()
                            enemy.id = self.sfidante["id"]!
                            enemy.nickName = self.sfidante["nickname"]!
                            
                            for user in self.players {
                                
                                if user.nickName == self.sfidante["nickname"]! {
                                    
                                    enemy.image = user.image
                                }
                            }
                            segue.enemy = enemy
                            
                            segue.fPlayer = true
                            segue.sPlayer = false
                            
                            self.present(segue, animated: true, completion: nil)
                        }
                    }
                    else {
                        ref.child("Players").child("\(MainViewController.user.id)").child("stato").setValue("online")
                        ref.child("Players").child("\(MainViewController.user.id)").child("invitoAccettato").setValue("")
                    }
                }
            }
            else {
                
                ref.child("Players").child("\(MainViewController.user.id)").child("invitatoDa").setValue("")
                ref.child("Players").child("\(MainViewController.user.id)").child("InvitoAccettato").setValue("")
                ref.child("Players").child("\(MainViewController.user.id)").child("loggato").setValue("No")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.selectedRow == indexPath.row {
            return 115.0
        }
        else{
            return 45.0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        tableView.beginUpdates()
        self.selectedRow = indexPath.row
        tableView.endUpdates()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! CustomLobbyCell
        
        self.sfidante.updateValue(ConvertOptionalString.convert(cell.nickNameLabel.text!), forKey: "nickname")
        
        self.statePlayerSelected = ConvertOptionalString.convert(cell.stateLabel.text!)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = lobbyTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomLobbyCell
        
        cell.nickNameLabel.text = players[indexPath.row].nickName
        cell.stateLabel.text = players[indexPath.row].stato
        cell.imageCell.image = players[indexPath.row].image
        cell.imageCell.layer.cornerRadius = cell.imageCell.frame.size.width / 2
        cell.imageCell.layer.masksToBounds = true
        
        cell.button1.layer.cornerRadius = cell.button1.frame.size.width / 2
        cell.button2.layer.cornerRadius = cell.button2.frame.size.width / 2
        
        
        
        cell.button1.setBackgroundImage(UIImage(named: "iconTris"), for: .normal)
        cell.button2.setBackgroundImage(UIImage(named: "checkIcon"), for: .normal)
        
        
      
        
        tableView.rowHeight = UIScreen.main.bounds.size.height / 8
        
        return cell
    }
    
    func refresh() -> Void {
        
        let ref = Database.database().reference()
        
        ref.child("Players").observeSingleEvent(of: .value, with:{ (snap) in
            
            self.players.removeAll()
            
            let players = snap.value as! [String : Any]
            
            for(key, value) in players {
                
                let datiSinglePlayer = value as! [String : Any]
                
                if key != MainViewController.user.id {
                    
                    let player = User()
                    player.id = key
                    player.nickName = datiSinglePlayer["nickname"] as! String
                    player.stato = datiSinglePlayer["stato"] as! String
                    
                    if player.stato == "online" {
                    
                        let decodeString = Data(base64Encoded: datiSinglePlayer["image"] as! String)
                        
                        let image = UIImage(data: decodeString!)
                        
                        let imagePNG = UIImagePNGRepresentation(image!)
                        
                        player.image = UIImage(data: imagePNG!)
                        
                        self.players.append(player)
                        self.lobbyTable.reloadData()
                    }
                }
            }
        })
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        refresh()
        refreshControl.endRefreshing()
        
    }
    @IBAction func goHome(_ sender: Any) {
        
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
