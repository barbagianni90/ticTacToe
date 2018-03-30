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
        
        let ref = Database.database().reference()
        
        ref.child("Players").observe(.value, with:{ (snap) in
            
            self.players.removeAll()
            
            let players = snap.value as! [String : Any]
            
            for(key, value) in players {
                
                let datiSinglePalyer = value as! [String : Any]
                
                if key != MainViewController.user.nickName {
                    let player = User()
                    player.nickName = key
                    player.stato = datiSinglePalyer["stato"] as! String
                    player.image = UIImage(named: "\(datiSinglePalyer["avatar"] as! String)")
                    self.players.append(player)
                }
            }
            self.lobbyTable.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let ref = Database.database().reference()
        
        ref.child("Players").child("\(MainViewController.user.nickName)").child("invitatoDa").observe(.value) { (snap) in
            
            let value = snap.value as! String
            
            if value != "" {
                
                ref.child("Players").child("\(MainViewController.user.nickName)").child("stato").setValue("occupato")
                
                let alert = UIAlertController(title: "\(value) ti ha invitato a giocare", message: nil, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Accetto", style: .default, handler: { action in
                    
                    ref.child("Players").child("\(value)").child("invitoAccettato").setValue("Si")
                    
                    
                    let segue =  UIStoryboard(name:"LobbyANDGame",bundle:nil).instantiateViewController(withIdentifier: "Gioco") as! GameViewController
                    
                    let enemy = User()
                    enemy.nickName = "\(value)"
                    
                    let segue2 = segue
                    segue2.enemy = enemy
                    
                    segue2.fPlayer = false
                    segue2.sPlayer = true
                    
                    self.present(segue, animated: true, completion: nil)
                }))
                
                alert.addAction(UIAlertAction(title: "Rifiuto", style: .default, handler: { action in
                    
                    ref.child("Players").child("\(value)").child("invitoAccettato").setValue("No")
                    ref.child("Players").child("\(MainViewController.user.nickName)").child("stato").setValue("online")
                }))
                
                self.present(alert, animated: true)
            }
        }
        
        ref.child("Players").child("\(MainViewController.user.nickName)").child("invitoAccettato").observe(.value) { (snap) in
            
            let value = snap.value as! String
            
            if value != "" {
                
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if value == "Si" {
                    
                    let segue =  UIStoryboard(name:"LobbyANDGame",bundle:nil).instantiateViewController(withIdentifier: "Gioco") as! GameViewController
                    
                    let enemy = User()
                    enemy.nickName = "\(self.nickNameSfidato)"
                    
                    let segue2 = segue
                    segue2.enemy = enemy
                    
                    segue2.fPlayer = true
                    segue2.sPlayer = false
                    
                    self.present(segue, animated: true, completion: nil)
                }
                else {
                    ref.child("Players").child("\(MainViewController.user.nickName)").child("stato").setValue("online")
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
        
        ref.child("Players").child("\(MainViewController.user.nickName)").child("stato").setValue("occupato")
        
        ref.child("Players").child("\(currentCell.nickNameLabel.text as! String)").child("invitatoDa").setValue("\(MainViewController.user.nickName)")
        
        self.nickNameSfidato = currentCell.nickNameLabel.text as! String
        
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(self.activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = lobbyTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomLobbyCell
        
        cell.nickNameLabel.text = players[indexPath.row].nickName
        cell.stateLabel.text = players[indexPath.row].stato
        cell.imageCell.image = players[indexPath.row].image
        
        return cell
    }

}
