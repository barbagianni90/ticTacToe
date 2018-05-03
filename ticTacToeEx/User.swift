//
//  User.swift
//  
//
//  Created by Stefano Apuzzo on 29/03/18.
//

import Foundation

import UIKit

class User {
    
    var nickName: String = ""
    var password: String = ""
    var vittorie: Int = 0
    var sconfitte: Int = 0
    var stato: String = ""
    var image: UIImage?
    
    init() {
        nickName = ""
        password = ""
        vittorie = 0
        sconfitte = 0
        stato = "offline"
    }
    init(_ nickName: String) {
        self.nickName = nickName
    }
    init(_ nickName: String, _ password: String, _ image: UIImage){
        self.nickName = nickName
        self.password = password
        self.image = image
    }
}
