//
//  GameCheckersViewController.swift
//  ticTacToeEx
//
//  Created by CertimeterGroup on 17/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit

class GameCheckersViewController: UIViewController {

    
    @IBOutlet weak var damieraImage: UIImageView!
    @IBOutlet weak var damieraStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set image damiera
        damieraImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: damieraImage, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: damieraImage, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 10).isActive = true
        
        NSLayoutConstraint(item: damieraImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width / 100) * 78).isActive = true
        
        NSLayoutConstraint(item: damieraImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width / 100) * 78).isActive = true
        
        damieraImage.image = UIImage(named: "damiera")
        
        damieraImage.contentMode = .scaleAspectFill
        
        view.sendSubview(toBack: damieraImage)
        
        //Stack view contraints
        damieraStackView.translatesAutoresizingMaskIntoConstraints = false
        
        damieraStackView.distribution = .fillEqually
        
        NSLayoutConstraint(item: damieraStackView, attribute: .top, relatedBy: .equal, toItem: damieraImage, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: damieraStackView, attribute: .bottom, relatedBy: .equal, toItem: damieraImage, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: damieraStackView, attribute: .left, relatedBy: .equal, toItem: damieraImage, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: damieraStackView, attribute: .right, relatedBy: .equal, toItem: damieraImage, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        //background
        let background: UIImageView!
        background = UIImageView(frame: view.bounds)
        background.contentMode = .scaleAspectFill
        background.clipsToBounds = true
        background.image = UIImage(named: "woodBack")
        background.center = view.center
        
        view.addSubview(background)
        view.sendSubview(toBack: background)
        
    }

    

}
