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
    
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var stateLabelTris: UILabel!
    @IBOutlet weak var stateLabelDama: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // HOME BUTTON
        
        
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        //        homeButton.layer.borderWidth = 0.5
        //        homeButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: homeButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        NSLayoutConstraint(item: homeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 15).isActive = true
        NSLayoutConstraint(item: homeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        NSLayoutConstraint(item: homeButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        
        homeButton.setTitle("Back", for: .normal)
        homeButton.titleLabel?.font = UIFont(name: "raleway", size: UIScreen.main.bounds.height / 6)
        homeButton.setTitleColor(UIColor.white, for: .normal)
        
        homeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        homeButton.titleLabel?.baselineAdjustment = .alignCenters
        
        
        
        // EDIT BUTTON
        
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
//        editButton.layer.borderWidth = 0.5
//        editButton.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: editButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: UIScreen.main.bounds.width / -15).isActive = true
        
        NSLayoutConstraint(item: editButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 15).isActive = true
        
        NSLayoutConstraint(item: editButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        NSLayoutConstraint(item: editButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        
        editButton.setTitle("Edit", for: .normal)
        editButton.titleLabel?.font = UIFont(name: "raleway", size: UIScreen.main.bounds.height / 6)
        editButton.setTitleColor(UIColor.white, for: .normal)
        
        editButton.titleLabel?.adjustsFontSizeToFitWidth = true
        editButton.titleLabel?.baselineAdjustment = .alignCenters
        
        
        //background
        let background: UIImageView!
        background = UIImageView(frame: view.frame)
        background.contentMode = .scaleAspectFill
        background.clipsToBounds = true
        background.image = UIImage(named: "start")
        background.center = view.center
        
        //blur effect
        let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
        blurEffect.frame = background.bounds
        background.addSubview(blurEffect)
        
        view.addSubview(background)
        view.sendSubview(toBack: background)
        
        
        
        // PROFILE LABEL
        
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: profileLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 8).isActive = true
        
        NSLayoutConstraint(item: profileLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: profileLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 2).isActive = true
        
        NSLayoutConstraint(item: profileLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 6).isActive = true
        
        profileLabel.adjustsFontSizeToFitWidth = true
        profileLabel.baselineAdjustment = .alignCenters
        profileLabel.textAlignment = .center
        
        let attTitleLabel = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.height / 6)]
        let profileLabelText = "Profile"
        let attStr = NSMutableAttributedString(string: profileLabelText, attributes: attTitleLabel)
        profileLabel.attributedText = attStr
        
        
        
        // AVATAR IMAGE
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        
//        avatarImage.layer.borderColor = UIColor.black.cgColor
//        avatarImage.layer.borderWidth = 0.5
        
        NSLayoutConstraint(item: avatarImage, attribute: .top, relatedBy: .equal, toItem: profileLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 40).isActive = true
        
        NSLayoutConstraint(item: avatarImage, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: avatarImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 3).isActive = true

        NSLayoutConstraint(item: avatarImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 3).isActive = true
        

        avatarImage.layer.cornerRadius = (UIScreen.main.bounds.width / 3) / 2
        avatarImage.contentMode = .scaleAspectFill
        
        
        
        
        // NICKNAME LABEL
        
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .top, relatedBy: .equal, toItem: avatarImage, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.height / 20).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 2).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height / 8).isActive = true
        
        nickNameLabel.adjustsFontSizeToFitWidth = true
        nickNameLabel.baselineAdjustment = .alignCenters
        nickNameLabel.textAlignment = .center
        
        
        let attUserLabel = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.height / 6)]
        let nickLabelText = ""
        let attNick = NSMutableAttributedString(string: nickLabelText, attributes: attUserLabel)
        nickNameLabel.attributedText = attNick
        
        
        
        
        
        // status label
        
        stateLabelTris.translatesAutoresizingMaskIntoConstraints = false
        stateLabelDama.translatesAutoresizingMaskIntoConstraints = false
        
//        stateLabel.layer.borderColor = UIColor.white.cgColor
//        stateLabel.layer.borderWidth = 0.5
        
        NSLayoutConstraint(item: stateLabelTris, attribute: .top, relatedBy: .equal, toItem: nickNameLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 20).isActive = true
        
        NSLayoutConstraint(item: stateLabelTris, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: UIScreen.main.bounds.size.width / 15).isActive = true
        
        NSLayoutConstraint(item: stateLabelTris, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 3).isActive = true
        
        NSLayoutConstraint(item: stateLabelTris, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 18).isActive = true
        
        
        let attStateLabel = [NSAttributedStringKey.font: UIFont(name: "raleway", size: UIScreen.main.bounds.size.height / 22)]
        let stateLabelText = ""
        let attState = NSMutableAttributedString(string: stateLabelText, attributes: attStateLabel)
        
        
        stateLabelTris.adjustsFontSizeToFitWidth = true
        stateLabelTris.baselineAdjustment = .alignCenters
        
        stateLabelTris.textAlignment = .center
        
        stateLabelTris.attributedText = attState
        
        
        NSLayoutConstraint(item: stateLabelDama, attribute: .top, relatedBy: .equal, toItem: nickNameLabel, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 20).isActive = true
        
        NSLayoutConstraint(item: stateLabelDama, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: UIScreen.main.bounds.size.width / -15).isActive = true
        
        NSLayoutConstraint(item: stateLabelDama, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 3).isActive = true
        
        NSLayoutConstraint(item: stateLabelDama, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 18).isActive = true
        
        
        stateLabelDama.adjustsFontSizeToFitWidth = true
        stateLabelDama.baselineAdjustment = .alignCenters
        
        stateLabelDama.textAlignment = .center
        
        stateLabelDama.attributedText = attState
        
        
        
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
//        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.size.width / 2
        self.avatarImage.layer.masksToBounds = true
        
        self.nickNameLabel.text = MainViewController.user.nickName
        self.nickNameLabel.font = UIFont(name: "raleway", size: UIScreen.main.bounds.height / 6)
        
    
        
        let vittorieTrisDouble: Float = Float(MainViewController.user.vittorieTris)
        
        let vittorieDamaDouble: Float = Float(MainViewController.user.vittorieDama)
        
        let sconfitteDamaDouble: Float = Float(MainViewController.user.sconfitteDama)
        
        let sconfitteTrisDouble: Float = Float(MainViewController.user.sconfitteTris)
        
        let percentualeVittorieTris: Float = ((vittorieTrisDouble / (vittorieTrisDouble + sconfitteTrisDouble))*100)
        let percentualeVittorieDama: Float = ((vittorieDamaDouble / (vittorieDamaDouble + sconfitteDamaDouble))*100)
        
        let string: String = "La blablablòa: "
        
        let concatTris: String = String(format: "%.2f", percentualeVittorieTris)
        let concatDama: String = String(format: "%.2f", percentualeVittorieDama)
        
        let perc: String = "%"
        
        let finalTris = string + concatTris + perc
        let finalDama = string + concatDama + perc
        
        self.stateLabelTris.text = finalTris
        self.stateLabelDama.text = finalDama
        
//        self.stateLabel.text = String(format: "la tua percentuale di vittorie è: %ld %", percentualeVittorie)
        
//        self.stateLabel.text = String(format: "La tua percentuale di vittorie è: %.2f \(percentualeVittorie)%")
        
//        self.stateLabel.font = UIFont(name: "raleway", size: UIScreen.main.bounds.size.height / 8)
        
        
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
