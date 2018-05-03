//
//  User.swift
//  TrisTest1
//
//  Created by Mac Luca on 26/03/18.
//  Copyright © 2018 Mac Luca. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    var id: String = ""
    var nickName: String = ""
    var email: String = ""
    var vittorieTris: Int = 0
    var vittorieDama: Int = 0
    var sconfitteTris: Int = 0
    var sconfitteDama: Int = 0
    var stato: String = ""
    var image: UIImage?
    var nameImage: String = ""
    
    
    init() {
        nickName = ""
        email = ""
        vittorieTris = 0
        vittorieDama = 0
        sconfitteTris = 0
        sconfitteDama = 0
        stato = "offline"
    }
    init(_ nickName: String) {
        self.nickName = nickName
    }
    init(_ nickName: String, _ email: String, _ image: UIImage){
        self.nickName = nickName
        self.email = email
        self.image = image
    }
}
