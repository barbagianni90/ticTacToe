//
//  ProfileViewController.swift
//  ticTacToeEx
//
//  Created by Stefano Apuzzo on 28/03/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // HOME BUTTON
        
        
        homeButton.translatesAutoresizingMaskIntoConstraints = false
                homeButton.layer.borderWidth = 0.5
                homeButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: homeButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        
        NSLayoutConstraint(item: homeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 20).isActive = true
        
        NSLayoutConstraint(item: homeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        NSLayoutConstraint(item: homeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        
        homeButton.setTitle("Home", for: .normal)
        homeButton.titleLabel?.font = UIFont(name: "shojumaru", size: UIScreen.main.bounds.width / 7)
        
        
        homeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        homeButton.titleLabel?.baselineAdjustment = .alignCenters
        
        
        
        // EDIT BUTTON
        
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.layer.borderWidth = 0.5
        editButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: editButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: UIScreen.main.bounds.width / -15).isActive = true
        
        NSLayoutConstraint(item: editButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 20).isActive = true
        
        NSLayoutConstraint(item: editButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        NSLayoutConstraint(item: editButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        
        editButton.setTitle("Edit", for: .normal)
        editButton.titleLabel?.font = UIFont(name: "shojumaru", size: UIScreen.main.bounds.width / 7)
        
        
        editButton.titleLabel?.adjustsFontSizeToFitWidth = true
        editButton.titleLabel?.baselineAdjustment = .alignCenters
        
        
        // BACKGROUND
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: backgroundImage, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: backgroundImage, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        
        NSLayoutConstraint(item: backgroundImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width).isActive = true
        
        NSLayoutConstraint(item: backgroundImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height).isActive = true
        
        backgroundImage.contentMode = .scaleAspectFill
        
        
        
        // PROFILE LABEL
        
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: profileLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 8).isActive = true
        
        NSLayoutConstraint(item: profileLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: profileLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 2).isActive = true
        
        NSLayoutConstraint(item: profileLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 8).isActive = true
        
        profileLabel.adjustsFontSizeToFitWidth = true
        profileLabel.baselineAdjustment = .alignCenters
        
        let attTitleLabel = [NSAttributedStringKey.font: UIFont(name: "shojumaru", size: UIScreen.main.bounds.width / 2)]
        let profileLabelText = "Profile"
        let attStr = NSMutableAttributedString(string: profileLabelText, attributes: attTitleLabel)
        profileLabel.attributedText = attStr
        
        
        
        // AVATAR IMAGE
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        
        avatarImage.layer.borderColor = UIColor.black.cgColor
        avatarImage.layer.borderWidth = 0.5
        
        NSLayoutConstraint(item: avatarImage, attribute: .top, relatedBy: .equal, toItem: profileLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 40).isActive = true
        
        NSLayoutConstraint(item: avatarImage, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: avatarImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 1.25).isActive = true

        NSLayoutConstraint(item: avatarImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 2).isActive = true
        
        avatarImage.layer.cornerRadius = (UIScreen.main.bounds.width / 1.25) / 2
        avatarImage.contentMode = .scaleAspectFill
        
        
        
        
        // NICKNAME LABEL
        
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .top, relatedBy: .equal, toItem: avatarImage, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 40).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 3).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 20).isActive = true
        
        nickNameLabel.adjustsFontSizeToFitWidth = true
        nickNameLabel.baselineAdjustment = .alignCenters
        nickNameLabel.textAlignment = .center
        
        
        let attUserLabel = [NSAttributedStringKey.font: UIFont(name: "catCafe", size: UIScreen.main.bounds.width / 3)]
        let nickLabelText = ""
        let attNick = NSMutableAttributedString(string: nickLabelText, attributes: attUserLabel)
        nickNameLabel.attributedText = attNick
        
        
        
        
        
        // status label
        
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: stateLabel, attribute: .top, relatedBy: .equal, toItem: nickNameLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 20).isActive = true
        
        NSLayoutConstraint(item: stateLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: stateLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 4).isActive = true
        NSLayoutConstraint(item: stateLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 20).isActive = true
        
        stateLabel.adjustsFontSizeToFitWidth = true
        stateLabel.baselineAdjustment = .alignCenters
        stateLabel.textAlignment = .center
        
        let attStateLabel = [NSAttributedStringKey.font: UIFont(name: "catCafe", size: UIScreen.main.bounds.width / 4)]
        let stateLabelText = ""
        let attState = NSMutableAttributedString(string: stateLabelText, attributes: attStateLabel)
        nickNameLabel.attributedText = attState
        
        
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goHome(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.avatarImage.image = MainViewController.user.image
        //self.avatarImage.transform = CGAffineTransform(rotationAngle: (90.0 * .pi) / 180.0)
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.size.width / 2
        self.avatarImage.layer.masksToBounds = true
        
        self.nickNameLabel.text = MainViewController.user.nickName
        
        self.stateLabel.text = MainViewController.user.stato
    }
   
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
