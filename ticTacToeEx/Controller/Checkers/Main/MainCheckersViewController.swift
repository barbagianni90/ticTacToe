//
//  MainCheckersViewController.swift
//  ticTacToeEx
//
//  Created by CertimeterGroup on 10/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit


class MainCheckersViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var checkersLabel: UILabel!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var rankingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set background
        background.translatesAutoresizingMaskIntoConstraints = false
        
        //top
        NSLayoutConstraint(item: background, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        //bottom
        NSLayoutConstraint(item: background, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        //left
        NSLayoutConstraint(item: background, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        //right
        NSLayoutConstraint(item: background, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        background.contentMode = .scaleAspectFill
        
        //set home button
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        
        //left
        NSLayoutConstraint(item: homeButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        //top
        NSLayoutConstraint(item: homeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 10).isActive = true
        //width
        NSLayoutConstraint(item: homeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 3).isActive = true
        //height
        NSLayoutConstraint(item: homeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width / 5) / 2).isActive = true
        
        homeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        homeButton.titleLabel?.baselineAdjustment = .alignCenters
        
        //set startButton
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        //centerX
        NSLayoutConstraint(item: startButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        //centerY
        NSLayoutConstraint(item: startButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        //width
        NSLayoutConstraint(item: startButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width / 8) * 5).isActive = true
        //height
        NSLayoutConstraint(item: startButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width / 32) * 3).isActive = true
        
        startButton.titleLabel?.adjustsFontSizeToFitWidth = true
        startButton.titleLabel?.baselineAdjustment = .alignCenters
        
        //set ranking button
        
        rankingButton.translatesAutoresizingMaskIntoConstraints = false
        
        //centerX
        NSLayoutConstraint(item: rankingButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        //top
        NSLayoutConstraint(item: rankingButton, attribute: .top, relatedBy: .equal, toItem: startButton, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 8).isActive = true
        //width
        NSLayoutConstraint(item: rankingButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width / 8) * 3).isActive = true
        //height
        NSLayoutConstraint(item: rankingButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width / 32) * 3).isActive = true
        
        rankingButton.titleLabel?.adjustsFontSizeToFitWidth = true
        rankingButton.titleLabel?.baselineAdjustment = .alignCenters
        
        //set checkers label
        checkersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //centerX
        NSLayoutConstraint(item: checkersLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        //width
        NSLayoutConstraint(item: checkersLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width / 4) * 3).isActive = true
        //bottom
        NSLayoutConstraint(item: checkersLabel, attribute: .bottom, relatedBy: .equal, toItem: startButton, attribute: .top, multiplier: 1, constant: -UIScreen.main.bounds.height / 16 ).isActive = true
        //top
        NSLayoutConstraint(item: checkersLabel, attribute: .top, relatedBy: .equal, toItem: homeButton, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 16 ).isActive = true
        
        checkersLabel.adjustsFontSizeToFitWidth = true
        checkersLabel.baselineAdjustment = .alignCenters
        
        
    }
    
    
    // Action function
    @IBAction func homeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func rankingButton(_ sender: Any) {

        let storyboard = UIStoryboard(name: "RankingDama", bundle: nil).instantiateViewController(withIdentifier: "RankingDama")
        self.present(storyboard, animated: true, completion: nil)
        
    }
    
    @IBAction func startGameAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "GameCheckers", bundle: nil).instantiateViewController(withIdentifier: "GameCheckID")
        self.present(storyboard, animated: true, completion: nil)
    }
    
    
    
    
}
