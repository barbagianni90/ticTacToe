//
//  LobbyViewController.swift
//  ticTacToeEx
//
//  Created by Mac Luca on 30/03/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit
import Firebase

class LobbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var players: [User] = []
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var nickNameSfidato: String = ""
    
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
    }
    
    func invite(notification: Notification) {
        
        let ref = Database.database().reference()
        
        if self.statePlayerSelected == "online" {
            
            ref.child("Players").child("\(MainViewController.user.id)").child("stato").setValue("occupato")
            
            for user in players {
                
                if user.nickName == self.nickNameSfidato{
                    
                    ref.child("Players").child("\(user.id)").child("invitatoDa").setValue("\(MainViewController.user.nickName)\(LobbyViewController.gameSelected)")
                }
            }
            self.activityIndicator.center = self.view.center
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            self.view.addSubview(self.activityIndicator)
            
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let ref = Database.database().reference()
        
        ref.child("Players").child("\(MainViewController.user.id)").child("invitatoDa").observe(.value) { (snap) in
            
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
                    ref.child("Players").child("\(MainViewController.user.id)").child("stato").setValue("online")
                }))
                
                self.present(alert, animated: true)
            }
        }
        
        ref.child("Players").child("\(MainViewController.user.id)").child("invitoAccettato").observe(.value) { (snap) in
            
            let value = snap.value as! String
            
            if value != "" {
                
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if value == "Si" {
                    
                    if LobbyViewController.gameSelected == "tris" {
                        
                        let segue = UIStoryboard(name:"GameTris",bundle:nil).instantiateViewController(withIdentifier: "GameTrisID") as! GameTrisViewController
                        
                        let enemy = User()
                        enemy.nickName = "\(self.nickNameSfidato)"
                        
                        for user in self.players {
                            
                            if user.nickName == self.nickNameSfidato {
                                
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
                        enemy.nickName = "\(self.nickNameSfidato)"
                        
                        for user in self.players {
                            
                            if user.nickName == self.nickNameSfidato {
                                
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
                }
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
        
        self.nickNameSfidato = ConvertOptionalString.convert(cell.nickNameLabel.text!)
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
        cell.button3.layer.cornerRadius = cell.button3.frame.size.width / 2
        
        cell.button1.setBackgroundImage(UIImage(named: "iconTris"), for: .normal)
        cell.button2.setBackgroundImage(UIImage(named: "checkIcon"), for: .normal)
        cell.button3.setBackgroundImage(UIImage(named: "chessIcon"), for: .normal)
        
        cell.button3.isEnabled = false
        cell.button3.alpha = 0.5
        
        tableView.rowHeight = CGFloat(45.0)
        
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
                    
                    if player.stato == "online" || player.stato == "occupato" {
                    
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
        
        self.dismiss(animated: true, completion: nil)
    }
}
