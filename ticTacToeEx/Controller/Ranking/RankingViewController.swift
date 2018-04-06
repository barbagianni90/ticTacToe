//
//  RankingViewController.swift
//  ticTacToeEx
//
//  Created by Stefano Apuzzo on 28/03/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var players: [User] = []
    
    @IBOutlet weak var tableRanking: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableRanking.delegate = self
        self.tableRanking.dataSource = self
        
        let ref = Database.database().reference()
        
        ref.child("Players").observe(.value, with: { (snap) in
            
            let players = snap.value as! [String : Any]
            
            for(key, value) in players{
                
                let datiSinglePlayer = value as! [String : Any]
                
                let player = User()
                
                player.nickName = key
                player.vittorie = Int(datiSinglePlayer["vittorie"] as! String)!
                
                let sRef = Storage.storage().reference()
                
                sRef.child("Images").child("\(key)").child("myImage.png").getData(maxSize: 20 * 1024 * 1024) { data, error in
                    if error != nil {
                        print(error as Any)
                    }
                    else {
                        player.image = UIImage(data: data!)
                        self.players.append(player)
                        self.players.sort(by: {$0.vittorie > $1.vittorie})
                        self.tableRanking.reloadData()
                    }
                }
            }
        })
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRank") as! CustomCellRanking
        
        cell.nickNameLabel.text = players[indexPath.row].nickName
        cell.scoreLabel.text = String(players[indexPath.row].vittorie)
        cell.imagePlayer.image = players[indexPath.row].image
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    @IBAction func goHome(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
