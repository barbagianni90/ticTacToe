//
//  CustomLobbyCell.swift
//  ticTacToeEx
//
//  Created by Mac Luca on 30/03/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit
import Firebase

class CustomLobbyCell: UITableViewCell {
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var stackViewGames: UIStackView!
    @IBOutlet weak var contentViewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // button 1 - tris
        
        stackViewGames.translatesAutoresizingMaskIntoConstraints = false

       

        NSLayoutConstraint(item: stackViewGames, attribute: .centerX, relatedBy: .equal, toItem: contentViewCell , attribute: .centerX, multiplier: 1, constant: 0).isActive = true

        NSLayoutConstraint(item: stackViewGames, attribute: .top, relatedBy: .equal, toItem: imageCell , attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 150).isActive = true

        NSLayoutConstraint(item: stackViewGames, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 1.5).isActive = true

        NSLayoutConstraint(item: stackViewGames, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 13).isActive = true

        stackViewGames.contentMode = .scaleAspectFill
        stackViewGames.distribution = .fillEqually
        
        //state label
        
        
        
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        stateLabel.layer.borderWidth = 0.5
//        stateLabel.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint(item: stateLabel, attribute: .right, relatedBy: .equal, toItem: contentViewCell, attribute: .right, multiplier: 1, constant: UIScreen.main.bounds.size.width / -20).isActive = true
        
        NSLayoutConstraint(item: stateLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 4).isActive = true
        
        NSLayoutConstraint(item: stateLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 40).isActive = true
        
        NSLayoutConstraint(item: stateLabel, attribute: .top, relatedBy: .equal, toItem: contentViewCell, attribute: .top, multiplier: 1, constant: contentViewCell.bounds.size.height / 20).isActive = true
        
        
        
        let attStateLabel = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.height / 12)]
        
        let stateLabelText = ""
        let attState = NSMutableAttributedString(string: stateLabelText, attributes: attStateLabel)
        
        stateLabel.attributedText = attState
        
        stateLabel.adjustsFontSizeToFitWidth = true
        stateLabel.baselineAdjustment = .alignCenters
        
        stateLabel.textAlignment = .right
        
        
        // nickname label cell
        
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
//        nickNameLabel.layer.borderColor = UIColor.white.cgColor
//        nickNameLabel.layer.borderWidth = 0.5
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .left, relatedBy: .equal, toItem: imageCell, attribute: .right, multiplier: 1, constant: UIScreen.main.bounds.size.width / 20).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 4).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 20).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .top, relatedBy: .equal, toItem: contentViewCell, attribute: .top, multiplier: 1, constant: contentViewCell.bounds.size.height / 20).isActive = true
        
        
        
        let attNickLabel = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.height / 12)]
        
        let nickLabelText = "Online"
        let attNick = NSMutableAttributedString(string: nickLabelText, attributes: attNickLabel)
        
        nickNameLabel.attributedText = attNick
        
        nickNameLabel.adjustsFontSizeToFitWidth = true
        nickNameLabel.baselineAdjustment = .alignCenters
        
        nickNameLabel.textAlignment = .left
        

        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func selectGame(_ sender: UIButton) {
        
        LobbyViewController.gameSelected = ConvertOptionalString.convert(sender.titleLabel?.text!)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue:"MyNotification"), object: nil)
        
    }
    
    
}
