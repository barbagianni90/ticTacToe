//
//  startingViewController.swift
//  ticTacToeEx
//
//  Created by CertimeterGroup on 16/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit

class startingViewController: UIViewController{
    
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var rankingButton: UIButton!
    @IBAction func trisButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Lobby", bundle: nil).instantiateViewController(withIdentifier: "lobby")
        self.present(storyboard, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var SMConstraint: NSLayoutConstraint!
    @IBOutlet weak var conteinerView: UIView!
    
    @IBOutlet weak var trisButton: UIButton!
    var images = ["iconTris", "checkIcon2"]
    var sideMenuConstraint: NSLayoutConstraint!
    var isSlideMenuHidden = true
    
    static var first: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trisButton.isEnabled = false
        startingViewController.first = true
        
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
         //-------------------------
        //sideMenuConstraints
        sideMenuView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: sideMenuView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: sideMenuView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: sideMenuView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width / 2) + 50).isActive = true
        SMConstraint.constant = -(UIScreen.main.bounds.width / 2) - 50
        
        sideMenuView.backgroundColor = UIColor.clear
        
        //collection view constraints
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: menuButton, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: sideMenuView, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        
        //flowLayout
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        
        collectionView?.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width / 2 - 50, bottom: (UIScreen.main.bounds.height - (UIScreen.main.bounds.height / 5 + 320))/2, right: UIScreen.main.bounds.width/2 - 50)
        
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.minimumLineSpacing = 60
        
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
        collectionView.backgroundColor = UIColor.clear
        
        //menu button constraints
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
//        menuButton.layer.borderColor = UIColor.white.cgColor
//        menuButton.layer.borderWidth = 0.5
        
        NSLayoutConstraint(item: menuButton, attribute: .left, relatedBy: .equal, toItem: sideMenuView, attribute: .right, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        NSLayoutConstraint(item: menuButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 10).isActive = true
        NSLayoutConstraint(item: menuButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 8).isActive = true
        NSLayoutConstraint(item: menuButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 8).isActive = true
        
        menuButton.setImage(UIImage(named: "menuButton"), for: .normal)
        menuButton.tintColor = UIColor.white
        
        
//        menuButton.titleLabel?.adjustsFontSizeToFitWidth = true
//        menuButton.titleLabel?.baselineAdjustment = .alignCenters
        
        //conteiner view constrains
        
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: conteinerView, attribute: .top, relatedBy: .equal, toItem: sideMenuView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: conteinerView, attribute: .bottom, relatedBy: .equal, toItem: sideMenuView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: conteinerView, attribute: .left, relatedBy: .equal, toItem: sideMenuView, attribute: .left, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: conteinerView, attribute: .right, relatedBy: .equal, toItem: sideMenuView, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        // TRIS BUTTON
        
        trisButton.translatesAutoresizingMaskIntoConstraints = false
        
//        trisButton.layer.borderWidth = 0.5
//        trisButton.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint(item: trisButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.size.height / 3).isActive = true
        
        NSLayoutConstraint(item: trisButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: trisButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 1.25).isActive = true
        
         NSLayoutConstraint(item: trisButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 8).isActive = true
        
        trisButton.setTitle("Start Game", for: .normal)
        trisButton.titleLabel?.font = UIFont(name: "Raleway-Light", size: UIScreen.main.bounds.size.height / 8)
        
        trisButton.setTitleColor(UIColor.white, for: .normal)
        
        trisButton.titleLabel?.adjustsFontSizeToFitWidth = true
        trisButton.titleLabel?.baselineAdjustment = .alignCenters
        
        
        
        
        // RANKING BUTTON
        
        rankingButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: rankingButton, attribute: .top, relatedBy: .equal, toItem: trisButton, attribute: .bottom, multiplier: 1, constant: UIScreen.main.bounds.size.height / 10).isActive = true
        
        NSLayoutConstraint(item: rankingButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: rankingButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.width / 2).isActive = true
        
        NSLayoutConstraint(item: rankingButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.size.height / 9).isActive = true
        
        rankingButton.setTitle("Ranking", for: .normal)
        rankingButton.setTitleColor(UIColor.white, for: .normal)
        rankingButton.titleLabel?.font = UIFont(name: "raleway", size: UIScreen.main.bounds.size.height / 9)
        
        rankingButton.titleLabel?.adjustsFontSizeToFitWidth = true
        rankingButton.titleLabel?.baselineAdjustment = .alignCenters
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        // constraints avatar button
        
        avatarButton.translatesAutoresizingMaskIntoConstraints = false
//                avatarButton.layer.borderWidth = 1
//                avatarButton.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint(item: avatarButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 9).isActive = true
        
        NSLayoutConstraint(item: avatarButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: (UIScreen.main.bounds.width / 10)*8).isActive = true
        
        NSLayoutConstraint(item: avatarButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 10).isActive = true
        
        NSLayoutConstraint(item: avatarButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 10).isActive = true
        
        
        avatarButton.imageView?.contentMode = .scaleAspectFill
        avatarButton.imageView?.layer.cornerRadius = (UIScreen.main.bounds.width / 7) / 2
        
        avatarButton.backgroundColor = UIColor.clear
        
        
        
        
        
        
        
        
        //set constraits nickname label
        
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //        nickNameLabel.layer.borderWidth = 0.5
        //        nickNameLabel.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 10.5).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .right, relatedBy: .equal, toItem: avatarButton, attribute: .left, multiplier: 1, constant: -10).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 2).isActive = true
        
        nickNameLabel.adjustsFontSizeToFitWidth = true
        nickNameLabel.textAlignment = .right
        
        //
        
        //        NSLayoutConstraint(item: nickNameLabel, attribute: .centerY, relatedBy: .equal, toItem: avatarButton, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: nickNameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 7).isActive = true
        
        nickNameLabel.baselineAdjustment = .alignCenters
        
        nickNameLabel.font = UIFont(name: "Raleway-Light", size: UIScreen.main.bounds.height / 23)
        nickNameLabel.textColor = UIColor.white
        
        
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !startingViewController.first && MainViewController.user.nickName != ""{
            hideSideMenu()
            isSlideMenuHidden = true
        }
       startingViewController.first = false
    }
    
    @IBAction func menuButtonAction(_ sender: UIButton) {
        if isSlideMenuHidden{
            showSideMenu()
        }else{
            hideSideMenu()
        }
        isSlideMenuHidden = !isSlideMenuHidden 
    }
    
    func showSideMenu(){
        SMConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func hideSideMenu(){
        SMConstraint.constant = -(UIScreen.main.bounds.width / 2) - 50
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if MainViewController.user.nickName == "" {
            self.avatarButton.isHidden = true
            self.nickNameLabel.isHidden = true
        }
        else{
            self.avatarButton.isHidden = false
            self.nickNameLabel.isHidden = false
            self.trisButton.isEnabled = true
            self.avatarButton.setBackgroundImage(MainViewController.user.image, for: .normal)
            //self.avatarButton.transform = CGAffineTransform(rotationAngle: (90.0 * .pi) / 180.0)
            self.avatarButton.layer.cornerRadius = UIScreen.main.bounds.width / 20
            self.avatarButton.layer.masksToBounds = true
            
            self.nickNameLabel.text = MainViewController.user.nickName
        }
        
        
    }
    
    
//    //UICollectionView Data Source
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
//
//        cell.iconImage.image = UIImage(named: images[indexPath.section])
//
//        return cell
//
//    }
//
//    //UICollectionView Flow Delegate
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 100)
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return images.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.section == 0{
//            let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainView")
//            self.present(storyboard, animated: true, completion: nil)
//        }else if indexPath.section == 1{
//            let storyboard = UIStoryboard(name: "MainCheckers", bundle: nil).instantiateViewController(withIdentifier: "MainCheckersID")
//            self.present(storyboard, animated: true, completion: nil)
//        }
//    }

}
