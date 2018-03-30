//
//  GameViewController.swift
//  ticTacToeEx
//
//  Created by Stefano Apuzzo on 28/03/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var quartoBut: UIButton!
    @IBOutlet weak var terzoBut: UIButton!
    
    @IBOutlet weak var secondBut: UIButton!
    @IBOutlet weak var primoBut: UIButton!
    
    @IBAction func crossBut(_ sender: Any) {
        
        let image = UIImage(named: "cross")
        primoBut.setImage(image, for: .normal)
        secondBut.setImage(image, for: .normal)
        
    }
    
    @IBAction func naughtBut(_ sender: Any) {
        
        let image = UIImage(named: "cerchio")
        terzoBut.setImage(image, for: .normal)
        quartoBut.setImage(image, for: .normal)

    }
    
    @IBAction func button(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "cherryTree")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
}
