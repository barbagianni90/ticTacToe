//
//  CustomUserChatCell.swift
//  ticTacToeEx
//
//  Created by Mac Luca on 04/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit

class CustomUserChatCell: UITableViewCell {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
