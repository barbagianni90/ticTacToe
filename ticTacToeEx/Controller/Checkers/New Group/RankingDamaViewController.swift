//
//  RankingDamaViewController.swift
//  ticTacToeEx
//
//  Created by Stefano Apuzzo on 10/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import Foundation
import UIKit

class RankingDamaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var rankingTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set background
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
        
        // set homeButton
        
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
        
        
        //set ranking label
        rankingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //top
        NSLayoutConstraint(item: rankingLabel, attribute: .top, relatedBy: .equal, toItem: homeButton, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        //bottom
        NSLayoutConstraint(item: rankingLabel, attribute: .bottom, relatedBy: .equal, toItem: rankingTable, attribute: .top, multiplier: 1, constant: 0).isActive = true
        //centerX
        NSLayoutConstraint(item: rankingLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        //width
        NSLayoutConstraint(item: rankingLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 2).isActive = true
        
        rankingLabel.adjustsFontSizeToFitWidth = true
        rankingLabel.baselineAdjustment = .alignCenters
        
        //set tableView
        
        rankingTable.translatesAutoresizingMaskIntoConstraints = false
        //left
        NSLayoutConstraint(item: rankingTable, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        //right
        NSLayoutConstraint(item: rankingTable, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        //bottom
        NSLayoutConstraint(item: rankingTable, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        //top
        NSLayoutConstraint(item: rankingTable, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 3).isActive = true
        
        
    }
    
    //Action
    @IBAction func homeButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    //Gestione Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        return cell!
    }
    
    
}
