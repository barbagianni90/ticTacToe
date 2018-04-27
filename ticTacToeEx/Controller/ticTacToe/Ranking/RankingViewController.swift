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
    
   
    
    @IBAction func segmented(_ sender: UISegmentedControl) {
        
//        switch sender.selectedSegmentIndex {
//        case 0:
//
//        default:
//            <#code#>
//        }
    }
    
    @IBOutlet weak var rankingLabel: UILabel!
    
    @IBOutlet weak var giocatoreLabel: UILabel!
    
    
    @IBOutlet weak var punteggioLabel: UILabel!
    
    @IBOutlet weak var titleStackview: UIStackView!
    @IBOutlet weak var sconfitteLabel: UILabel!
    
    @IBOutlet weak var mediaLabel: UILabel!
    
    @IBOutlet weak var homeButton: UIButton!
    
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
        
        
        segmented.isHidden = true
        
        
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
        
        
        
        
        
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        //        homeButton.layer.borderWidth = 0.5
        //        homeButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: homeButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        
        NSLayoutConstraint(item: homeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 28).isActive = true
        
        NSLayoutConstraint(item: homeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        NSLayoutConstraint(item: homeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        
        homeButton.setTitle("Home", for: .normal)
        homeButton.titleLabel?.font = UIFont(name: "raleway", size: UIScreen.main.bounds.height / 6)
        
        
        homeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        homeButton.titleLabel?.baselineAdjustment = .alignCenters
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // ranking label
        
        rankingLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        rankingLabel.layer.borderColor = UIColor.white.cgColor
//        rankingLabel.layer.borderWidth = 0.5
        
        NSLayoutConstraint(item: rankingLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.size.height / 10).isActive = true
        
        NSLayoutConstraint(item: rankingLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: rankingLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 2).isActive = true
        
        NSLayoutConstraint(item: rankingLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 6).isActive = true
        
        let attTitleLabel = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.height / 6)]
        
        let rankingLabelText = "Ranking"
        let attRank = NSMutableAttributedString(string: rankingLabelText, attributes: attTitleLabel)
        
        rankingLabel.attributedText = attRank
        
        rankingLabel.adjustsFontSizeToFitWidth = true
        rankingLabel.baselineAdjustment = .alignCenters
        
        
        // punteggio label
//
//        punteggioLabel.translatesAutoresizingMaskIntoConstraints = false
//
////        punteggioLabel.layer.borderColor = UIColor.white.cgColor
////        punteggioLabel.layer.borderWidth = 0.5
//
//        NSLayoutConstraint(item: punteggioLabel, attribute: .top, relatedBy: .equal, toItem: rankingLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 10).isActive = true
//
//        NSLayoutConstraint(item: punteggioLabel, attribute: .right, relatedBy: .equal, toItem: sconfitteLabel, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.size.width / -15).isActive = true
//
//
//        NSLayoutConstraint(item: punteggioLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 4).isActive = true
//
//        NSLayoutConstraint(item: punteggioLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 20).isActive = true
//
//
//
//        let attPunteggioLabel = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.height / 12)]
//
//        let punteggioLabelText = "V"
//        let attPunteggio = NSMutableAttributedString(string: punteggioLabelText, attributes: attPunteggioLabel)
//
//        punteggioLabel.attributedText = attPunteggio
//
//        punteggioLabel.adjustsFontSizeToFitWidth = true
//        punteggioLabel.baselineAdjustment = .alignCenters
//
       
        // title stack view
        
        titleStackview.translatesAutoresizingMaskIntoConstraints = false
        
    
        
        NSLayoutConstraint(item: titleStackview, attribute: .top, relatedBy: .equal, toItem: rankingLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 10).isActive = true
        
        NSLayoutConstraint(item: titleStackview, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -40).isActive = true
        
        NSLayoutConstraint(item: titleStackview, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 20).isActive = true
        
        
        
        
        // giocatore label
        
        giocatoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        giocatoreLabel.layer.borderColor = UIColor.white.cgColor
//        giocatoreLabel.layer.borderWidth = 0.5
        
        NSLayoutConstraint(item: giocatoreLabel, attribute: .top, relatedBy: .equal, toItem: rankingLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 10).isActive = true
        
        NSLayoutConstraint(item: giocatoreLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.size.width / 15).isActive = true
        
        
        NSLayoutConstraint(item: giocatoreLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 4).isActive = true
        
        NSLayoutConstraint(item: giocatoreLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 20).isActive = true
        
        
        
        let attGiocatoreLabel = [NSAttributedStringKey.font: UIFont(name: "raleway", size: 17)]
        
        let giocatoreLabelText = "Giocatore"
        let attGiocatore = NSMutableAttributedString(string: giocatoreLabelText, attributes: attGiocatoreLabel)
        
        giocatoreLabel.attributedText = attGiocatore
        
        giocatoreLabel.adjustsFontSizeToFitWidth = true
        giocatoreLabel.baselineAdjustment = .alignCenters
        
        
        
        
        
        // tableview
        
        
        tableRanking.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: tableRanking, attribute: .top, relatedBy: .equal, toItem: punteggioLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 100).isActive = true
        
        NSLayoutConstraint(item: tableRanking, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: tableRanking, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width).isActive = true
        
        NSLayoutConstraint(item: tableRanking, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellRank") as! CustomCellRanking
        
        cell.nickNameLabel.text = players[indexPath.row].nickName
        cell.scoreLabel.text = String(players[indexPath.row].vittorie)
        cell.imagePlayer.image = players[indexPath.row].image
        
        cell.imagePlayer.layer.cornerRadius = cell.imagePlayer.frame.size.width / 2
        cell.imagePlayer.layer.masksToBounds = true
        
        
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
        
        
        let ref = Database.database().reference()
        
        ref.child("Players").observeSingleEvent(of: .value, with: { (snap) in
            self.players.removeAll()

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
