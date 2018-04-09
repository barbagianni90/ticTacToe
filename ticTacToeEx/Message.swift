//
//  Message.swift
//  ticTacToeEx
//
//  Created by Mac Luca on 04/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import Foundation
import UIKit

class Message {
    
    var nickName: String = ""
    var message: String = ""
    var imageProgile: UIImage!
    var n_message: Int = 0
    
    init() {
        self.nickName = ""
        self.message = ""
    }
    init(_ nickName: String, _ message: String, _ image: UIImage){
        self.nickName = nickName
        self.message = message
        self.imageProgile = image
    }
}
