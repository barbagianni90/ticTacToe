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

    @IBOutlet weak var segmented: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableRanking.delegate = self
        self.tableRanking.dataSource = self
        
        refresh()
        
        let refreshControl: UIRefreshControl = {
            
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:
                #selector(LobbyViewController.handleRefresh(_:)),
                                     for: UIControlEvents.valueChanged)
            refreshControl.tintColor = UIColor.red
            
            return refreshControl
        }()
        
        self.tableRanking.addSubview(refreshControl)
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
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        refresh()
        refreshControl.endRefreshing()
        
    }
    
    func refresh() {
        
        self.players.removeAll()
        
        let ref = Database.database().reference()
        
        ref.child("Players").observeSingleEvent(of: .value, with: { (snap) in
            
            let players = snap.value as! [String : Any]
            
            for(key, value) in players{
                
                let datiSinglePlayer = value as! [String : Any]
                
                let player = User()
                
                player.id = key
                player.nickName = datiSinglePlayer["nickname"] as! String
                player.vittorie = Int(datiSinglePlayer["vittorie"] as! String)!
                
                let decodeString = Data(base64Encoded: datiSinglePlayer["image"] as! String)
                
                let image = UIImage(data: decodeString!)
                
                let imagePNG = UIImagePNGRepresentation(image!)
                
                player.image = UIImage(data: imagePNG!)
                
                self.players.append(player)
                
            }
            self.players.sort(by: {$0.vittorie > $1.vittorie})
            self.tableRanking.reloadData()
        })
    }
}
