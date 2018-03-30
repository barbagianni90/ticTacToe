//
//  GameViewController.swift
//  ticTacToeEx
//
//  Created by Stefano Apuzzo on 28/03/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import Foundation
import UIKit

class Utils{
    
    static func collectionToArray2D(arr: [UIButton],size: Int) -> [[UIButton]]{
        
        var result : [[UIButton]] = [[UIButton]](repeating: [UIButton](), count: size);
        var set = -1;
        let expectedSize = (arr.count / size) + (arr.count % size);
        
        for i in 0..<arr.count {
            if i % expectedSize == 0{
                set = set + 1;
            }
            
            result[set].append(arr[i]);
        }
        
        return result;
    }
    
}

class GameViewController: UIViewController {
    
    var enemy = User()
    
    var fPlayer = false
    var sPlayer = false
    
    var nomeTabella = ""
    
    var vittorie: Int!
    var sconfitte: Int!
    
    var matrice: [[String]] = [["", "", ""], ["", "", ""],["","",""]]
    
    var myImage: UIImage!
    var oppositeImage: UIImage!
    
    var buttons2D: [[UIButton]]!
    var buttonEnabled = 9
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
