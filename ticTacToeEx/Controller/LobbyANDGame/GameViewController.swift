//
//  GameViewController.swift
//  ticTacToeEx
//
//  Created by Stefano Apuzzo on 28/03/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

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
    
    @IBOutlet var buttons: [UIButton]!
    var buttons2D: [[UIButton]]!
    var buttonEnabled = 9
    
    var partitaFinita = false {
        didSet {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = Database.database().reference()
        
        
        if fPlayer == true && sPlayer == false {
            
            nomeTabella = "\(MainViewController.user.nickName)VS\(self.enemy.nickName)"
        }
        else if fPlayer == false && sPlayer == true {
            
            nomeTabella = "\(self.enemy.nickName)VS\(MainViewController.user.nickName)"
        }
        
        for i in 0...2 {
            for y in 0...2 {
                ref.child("\(nomeTabella)").child("\(i):\(y)").child("toccata").setValue("")
                ref.child("\(nomeTabella)").child("\(i):\(y)").child("daChi").setValue("")
            }
        }
        ref.child("Utility\(nomeTabella)").child("buttonEnabled").setValue("9")
        self.buttonEnabled = 9
        
        
        buttons2D = Utils.collectionToArray2D(arr: buttons, size: 3)
        
        for buttons in buttons2D {
            for button in buttons {
                button.layer.borderColor = UIColor.black.cgColor
                button.layer.borderWidth = 1
            }
        }
        
        
        if fPlayer == true {
            myImage = UIImage(named: "crossRossa.png")
            oppositeImage = UIImage(named: "cerchioRosso.png")
        }
        else if sPlayer == true {
            myImage = UIImage(named: "cerchioRosso.png")
            oppositeImage = UIImage(named: "crossRossa.png")
        }
        
        
        ref.child("Utility\(nomeTabella)").observe(.value) { (snap) in
            
            let utility = snap.value as! [String : Any]
            let tmp = utility["buttonEnabled"] as! String
            self.buttonEnabled = Int(tmp)!
        }
        
        ref.child("\(nomeTabella)").observe(.value) { (snap) in
            
            let celle = snap.value as! [String : Any]
            
            for(key, value) in celle {
                
                let x = Int(String(key.first as! Character)) as! Int
                let y = Int(String(key.last as! Character)) as! Int
                
                let dati = value as! [String : String]
                
                let toccata = dati["toccata"] as! String
                let daChi = dati["daChi"] as! String
                
                if toccata == "Si" {
                    if daChi == MainViewController.user.nickName && self.fPlayer == true {
                        self.matrice[x][y] = "x"
                        self.buttons2D[x][y].setImage(self.myImage, for: .normal)
                    }
                    else if daChi == MainViewController.user.nickName && self.sPlayer == true {
                        self.matrice[x][y] = "o"
                        self.buttons2D[x][y].setImage(self.myImage, for: .normal)
                    }
                    else if daChi != MainViewController.user.nickName && self.fPlayer == true {
                        self.matrice[x][y] = "o"
                        self.buttons2D[x][y].setImage(self.oppositeImage, for: .normal)
                    }
                    else if daChi != MainViewController.user.nickName && self.sPlayer == true {
                        self.matrice[x][y] = "x"
                        self.buttons2D[x][y].setImage(self.oppositeImage, for: .normal)
                    }
                    
                    let winner = self.getWinner()
                    if winner == "Hai vinto" {
                        
                        ref.child("Players").child("\(MainViewController.user.nickName)").child("vittorie").setValue("\(MainViewController.user.vittorie + 1)")
                        
                        ref.child("Players").child("\(MainViewController.user.nickName)").child("invitatoDa").setValue("")
                        ref.child("Players").child("\(MainViewController.user.nickName)").child("invitoAccettato").setValue("")
                        ref.child("Players").child("\(MainViewController.user.nickName)").child("stato").setValue("online")
                        
                        ref.child("\(self.nomeTabella)").removeAllObservers()
                        ref.child("Utility\(self.nomeTabella)").removeAllObservers()
                        
                        let alert = UIAlertController(title: "Hai vinto", message: "Complimenti", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            self.partitaFinita = true
                        }))
                        
                        self.present(alert, animated: true)
                        
                        
                    }
                    else if winner == "Hai perso" {
                        
                        ref.child("Players").child("\(MainViewController.user.nickName)").child("sconfitte").setValue("\(MainViewController.user.sconfitte + 1)")
                        ref.child("Players").child("\(MainViewController.user.nickName)").child("invitatoDa").setValue("")
                        ref.child("Players").child("\(MainViewController.user.nickName)").child("invitoAccettato").setValue("")
                        ref.child("Players").child("\(MainViewController.user.nickName)").child("stato").setValue("online")
                        
                        ref.child("\(self.nomeTabella)").removeAllObservers()
                        ref.child("Utility\(self.nomeTabella)").removeAllObservers()
                        
                        ref.child("\(self.nomeTabella)").removeValue()
                        ref.child("Utility\(self.nomeTabella)").removeValue()
                        
                        let alert = UIAlertController(title: "Hai perso", message: "Mi spiace", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            self.partitaFinita = true
                        }))
                        
                        self.present(alert, animated: true)
                        
                    }
                }
            }
        }
        
    }
    
    @IBAction func mossa(_ sender: UIButton) {
        
        let x = Int(String(sender.titleLabel?.text?.first as! Character)) as! Int
        let y = Int(String(sender.titleLabel?.text?.last as! Character)) as! Int
        
        if fPlayer == true {
            if buttonEnabled%2 != 0 && self.matrice[x][y] == "" {
                
                self.matrice[x][y] = "x"
                
                let ref = Database.database().reference()
                ref.child("\(nomeTabella)").child("\(sender.titleLabel?.text as! String)").setValue(["daChi":"\(MainViewController.user.nickName)","toccata":"Si"])
                ref.child("Utility\(nomeTabella)").child("buttonEnabled").setValue("\(buttonEnabled - 1)")
            }
        }
        else if sPlayer == true && self.matrice[x][y] == ""{
            if buttonEnabled%2 == 0 {
                
                self.matrice[x][y] = "o"
                
                let ref = Database.database().reference()
                ref.child("\(nomeTabella)").child("\(sender.titleLabel?.text as! String)").setValue(["daChi":"\(MainViewController.user.nickName)","toccata":"Si"])
                ref.child("Utility\(nomeTabella)").child("buttonEnabled").setValue("\(buttonEnabled - 1)")
            }
        }
    }
    
    
    func getWinner() -> String
    {
        
        var k = 0;
        var h = 0;
        // Verifico se il tris è presente in una riga
        for i in 0...2
        {
            for j in 0...2
            {
                if matrice[i][j] != nil && matrice[i][j] == "x"
                {
                    k += 1
                    if(k==3){
                        if fPlayer == true {
                            return "Hai vinto"
                        }
                        else {
                            return "Hai perso"
                        }
                    }
                }
                else
                {
                    if matrice[i][j] != nil && matrice[i][j] == "o"
                    {
                        h += 1;
                        if(h==3){
                            if fPlayer == true {
                                return "Hai perso"
                            }
                            else {
                                return "Hai vinto"
                            }
                        }
                    }
                }
            }
            k=0
            h=0
        }
        // Verifico se il tris è presente in una colonna
        for i in 0...2
        {
            for j in 0...2
            {
                if matrice[j][i] != nil && matrice[j][i] == "x"
                {
                    k += 1
                    if(k==3){
                        if fPlayer == true {
                            return "Hai vinto"
                        }
                        else {
                            return "Hai perso"
                        }
                    }
                }
                else
                {
                    if matrice[j][i] != nil && matrice[j][i] == "o"
                    {
                        h += 1;
                        if(h==3){
                            if fPlayer == true {
                                return "Hai perso"
                            }
                            else {
                                return "Hai vinto"
                            }
                        }
                    }
                }
            }
            k=0
            h=0
        }
        
        // Verifico se il tris è presente in una diagonale
        for i in 0...2
        {
            let j = i;
            if matrice[i][j] != nil && matrice[i][j] == "x"
            {
                k += 1;
                if(k==3){
                    if fPlayer == true {
                        return "Hai vinto"
                    }
                    else {
                        return "Hai perso"
                    }
                }
            }
            else
            {
                if matrice[i][j] != nil && matrice[i][j] == "o"
                {
                    h += 1
                    if(h==3){
                        if fPlayer == true {
                            return "Hai perso"
                        }
                        else {
                            return "Hai vinto"
                        }
                    }
                }
            }
        }
        
        k=0
        h=0
        var j = 2
        
        for i in 0...2
        {
            if matrice[i][j] != nil && matrice[i][j] == "x"
            {
                k += 1;
                if(k==3){
                    if fPlayer == true {
                        return "Hai vinto"
                    }
                    else {
                        return "Hai perso"
                    }
                }
            }
            else
            {
                if matrice[i][j] != nil && matrice[i][j] == "o"
                {
                    h += 1;
                    if(h==3){
                        if fPlayer == true {
                            return "Hai perso"
                        }
                        else {
                            return "Hai vinto"
                        }
                    }
                }
            }
            j -= 1
        }
        return " "
    }
}
