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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let ref = Database.database().reference()
        
        ref.child("Players").child("\(MainViewController.user.id)").child("invitatoDa").observe(.value) { (snap) in
            
            let value = snap.value as! String
            
            if value != "" {
                
                ref.child("Players").child("\(MainViewController.user.id)").child("stato").setValue("occupato")
                
                var idNickInvito = ""
                
                for user in self.players {
                    
                    if user.nickName == value {
                        
                        idNickInvito = user.id
                    }
                }
                
                let alert = UIAlertController(title: "\(value) ti ha invitato a giocare", message: nil, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Accetto", style: .default, handler: { action in
                    
                    ref.child("Players").child("\(idNickInvito)").child("invitoAccettato").setValue("Si")
                        
                        let segue =  UIStoryboard(name:"LobbyANDGame",bundle:nil).instantiateViewController(withIdentifier: "Gioco") as! GameViewController
                        
                        let enemy = User()
                        enemy.nickName = "\(value)"
                    
                        for user in self.players {
                        
                            if user.nickName == value {
                            
                                enemy.image = user.image
                            }
                        }
                        segue.enemy = enemy
                    
                        segue.fPlayer = false
                        segue.sPlayer = true
                        
                        self.present(segue, animated: true, completion: nil)
                    })
                )
                
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
                    
                    let segue =  UIStoryboard(name:"LobbyANDGame",bundle:nil).instantiateViewController(withIdentifier: "Gioco") as! GameViewController
                    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentCell = tableView.cellForRow(at: indexPath) as! CustomLobbyCell
        
        let ref = Database.database().reference()
        
        if currentCell.stateLabel.text == "online" {
            
            ref.child("Players").child("\(MainViewController.user.id)").child("stato").setValue("occupato")
            
            for user in players {
                
                if user.nickName == currentCell.nickNameLabel.text as! String {
                    
                    ref.child("Players").child("\(user.id)").child("invitatoDa").setValue("\(MainViewController.user.nickName)")
                }
            }
            
            self.nickNameSfidato = currentCell.nickNameLabel.text as! String
            
            self.activityIndicator.center = self.view.center
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            self.view.addSubview(self.activityIndicator)
            
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = lobbyTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomLobbyCell
        
        cell.nickNameLabel.text = players[indexPath.row].nickName
        cell.stateLabel.text = players[indexPath.row].stato
        cell.imageCell.image = players[indexPath.row].image
        //cell.imageCell.transform =  CGAffineTransform(rotationAngle: (90.0 * .pi) / 180.0)
        cell.imageCell.layer.cornerRadius = cell.imageCell.frame.size.width / 2
        cell.imageCell.layer.masksToBounds = true
        
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
