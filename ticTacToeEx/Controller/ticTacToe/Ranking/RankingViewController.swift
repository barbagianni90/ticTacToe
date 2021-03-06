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
    

    var rankingSelected: String = "" {
        didSet{
            self.refresh()
        }
    }

   
    @IBOutlet weak var posizioneLabel: UILabel!
    
    @IBOutlet weak var labelFissa: UILabel!
    
    @IBAction func segmented(_ sender: UISegmentedControl) {

        switch sender.selectedSegmentIndex {

        case 0:

            self.rankingSelected = "tris"
            
        case 1:

            self.rankingSelected = "dama"

        default:

            break
        }
    }

    @IBOutlet weak var rankingLabel: UILabel!
    
    @IBOutlet weak var giocatoreLabel: UILabel!
    
    
    @IBOutlet weak var punteggioLabel: UILabel!
    
    @IBOutlet weak var sconLabel: UILabel!
    
    @IBOutlet weak var mediaLabel: UILabel!
    
    @IBOutlet weak var titleStackview: UIStackView!
    
    
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
        
        
        //HOME BUTTON
        
        
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
        
        
        
        
        
        // ranking label
        
        rankingLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        rankingLabel.layer.borderColor = UIColor.white.cgColor
//        rankingLabel.layer.borderWidth = 0.5
        
        NSLayoutConstraint(item: rankingLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.size.height / 10).isActive = true
        
        NSLayoutConstraint(item: rankingLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: rankingLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 2).isActive = true
        
        NSLayoutConstraint(item: rankingLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 10).isActive = true
        
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
        
        
        // LABEL FISSA
        
        labelFissa.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint(item: labelFissa, attribute: .top, relatedBy: .equal, toItem: rankingLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 30).isActive = true
        
        NSLayoutConstraint(item: labelFissa, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.size.width / 12).isActive = true
        
        
        NSLayoutConstraint(item: labelFissa, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 3).isActive = true
        
        
        NSLayoutConstraint(item: labelFissa, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 12).isActive = true
        
        
        let attLabelFissa = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.height / 12)]
        
        let LabelFissaText = "La tua posizione è: "
        let attFissa = NSMutableAttributedString(string: LabelFissaText, attributes: attLabelFissa)
        
        labelFissa.attributedText = attFissa
        
        labelFissa.adjustsFontSizeToFitWidth = true
        labelFissa.baselineAdjustment = .alignCenters
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // POSIZIONE LABEL
        
        posizioneLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: posizioneLabel, attribute: .top, relatedBy: .equal, toItem: rankingLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 40).isActive = true
        
        NSLayoutConstraint(item: posizioneLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: UIScreen.main.bounds.size.width / -10).isActive = true
        
        
        NSLayoutConstraint(item: posizioneLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 6).isActive = true
        
   
         NSLayoutConstraint(item: posizioneLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 6).isActive = true
        
        let attLabelPosizione = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.height / 12)]
        
        let LabelPosizioneText = ""
        let attPosizione = NSMutableAttributedString(string: LabelPosizioneText, attributes: attLabelPosizione)
        
        posizioneLabel.attributedText = attPosizione
        
        posizioneLabel.adjustsFontSizeToFitWidth = true
        posizioneLabel.baselineAdjustment = .alignCenters
        
        
 
        
        
        // SEGMENTED
        
        segmented.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint(item: segmented, attribute: .top, relatedBy: .equal, toItem: posizioneLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 40).isActive = true
        
        NSLayoutConstraint(item: segmented, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        
        NSLayoutConstraint(item: segmented, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 1.25).isActive = true
        
        
        NSLayoutConstraint(item: segmented, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 16).isActive = true
       
        
        
        
        
        
        
        
        
        
        
       
        // title stack view
        
        titleStackview.translatesAutoresizingMaskIntoConstraints = false
        
    
        
        NSLayoutConstraint(item: titleStackview, attribute: .top, relatedBy: .equal, toItem: segmented, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 30).isActive = true
        
        NSLayoutConstraint(item: titleStackview, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -20).isActive = true
        
        NSLayoutConstraint(item: titleStackview, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 20).isActive = true
        
        
        
        
        // giocatore label
        
        giocatoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        giocatoreLabel.layer.borderColor = UIColor.white.cgColor
//        giocatoreLabel.layer.borderWidth = 0.5
        
        NSLayoutConstraint(item: giocatoreLabel, attribute: .top, relatedBy: .equal, toItem: segmented, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 30).isActive = true
        
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
        
        if self.segmented.selectedSegmentIndex == 1 {
            cell.vittorieLabel.text = String(players[indexPath.row].vittorieTris)
            cell.sconfitteLabel.text = String(players[indexPath.row].sconfitteTris)
            
            if players[indexPath.row].sconfitteTris != 0 {
               
                if(players[indexPath.row].vittorieTris % players[indexPath.row].sconfitteTris) == 0{
                    cell.scoreLabel.text = String((players[indexPath.row].vittorieTris) / (players[indexPath.row].sconfitteTris))
                }else{
                    let score: Float = Float(players[indexPath.row].vittorieTris) / Float(players[indexPath.row].sconfitteTris)
                    
                    cell.scoreLabel.text = String(format: "%.2f", score)
                }
            }
            else {
                cell.scoreLabel.text = String(players[indexPath.row].vittorieTris)
            }
        }
        else {
            
            cell.vittorieLabel.text = String(players[indexPath.row].vittorieDama)
            cell.sconfitteLabel.text = String(players[indexPath.row].sconfitteDama)
            
            if players[indexPath.row].sconfitteDama != 0 {
                
                if(players[indexPath.row].vittorieDama % players[indexPath.row].sconfitteDama) == 0{
                    cell.scoreLabel.text = String((players[indexPath.row].vittorieDama) / (players[indexPath.row].sconfitteDama))
                }else{
                    let score: Float = Float(players[indexPath.row].vittorieDama) / Float(players[indexPath.row].sconfitteDama)
                    
                    cell.scoreLabel.text = String(format: "%.2f", score)
                }
                
            }
            else {
                cell.scoreLabel.text = String(players[indexPath.row].vittorieDama)
            }
        }
        
        
        cell.nickNameLabel.text = players[indexPath.row].nickName
        
        if MainViewController.user.nickName == players[indexPath.row].nickName{
            cell.nickNameLabel.textColor = UIColor.white
        }else{
            cell.nickNameLabel.textColor = UIColor.black
        }
        
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
    
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        
        if self.segmented.selectedSegmentIndex == 1 {
            self.players.sort(by: {$0.vittorieTris > $1.vittorieTris})
        }else {
            self.players.sort(by: {$0.vittorieDama > $1.vittorieDama})
        }
        
        tableRanking.reloadData()
        
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
                player.vittorieTris = Int(datiSinglePlayer["vittorieTris"] as! String)!
                player.vittorieDama = Int(datiSinglePlayer["vittorieDama"] as! String)!
                player.sconfitteTris = Int(datiSinglePlayer["sconfitteTris"] as! String)!
                player.sconfitteDama = Int(datiSinglePlayer["sconfitteDama"] as! String)!
                
                let decodeString = Data(base64Encoded: datiSinglePlayer["image"] as! String)
                
                let image = UIImage(data: decodeString!)
                
                let imagePNG = UIImagePNGRepresentation(image!)
                
                player.image = UIImage(data: imagePNG!)
                
                self.players.append(player)
                
            }
            if self.segmented.selectedSegmentIndex == 1 {
                self.players.sort(by: {$0.vittorieTris > $1.vittorieTris})
            }
            else {
                self.players.sort(by: {$0.vittorieDama > $1.vittorieDama})
            }
            
            self.tableRanking.reloadData()
        })
    }
}
