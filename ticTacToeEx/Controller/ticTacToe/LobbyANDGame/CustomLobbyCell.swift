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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
