//
//  startingViewController.swift
//  ticTacToeEx
//
//  Created by CertimeterGroup on 16/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit

class startingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var SMConstraint: NSLayoutConstraint!
    @IBOutlet weak var conteinerView: UIView!
    
    var images = ["iconTris", "checkIcon2"]
    var sideMenuConstraint: NSLayoutConstraint!
    var isSlideMenuHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //background
        let background: UIImageView!
        background = UIImageView(frame: view.bounds)
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
        
        //sideMenuConstraints
        sideMenuView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: sideMenuView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: sideMenuView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: sideMenuView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width / 2) + 50).isActive = true
        SMConstraint.constant = -(UIScreen.main.bounds.width / 2) - 50
        
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = UIColor.clear
        
        //menu button constraints
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: menuButton, attribute: .left, relatedBy: .equal, toItem: sideMenuView, attribute: .right, multiplier: 1, constant: UIScreen.main.bounds.width / 15).isActive = true
        NSLayoutConstraint(item: menuButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: UIScreen.main.bounds.height / 10).isActive = true
        NSLayoutConstraint(item: menuButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width / 5).isActive = true
        NSLayoutConstraint(item: menuButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (UIScreen.main.bounds.width / 5) / 2).isActive = true
        
        menuButton.titleLabel?.adjustsFontSizeToFitWidth = true
        menuButton.titleLabel?.baselineAdjustment = .alignCenters
        
        //conteiner view constrains
        
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: conteinerView, attribute: .top, relatedBy: .equal, toItem: sideMenuView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: conteinerView, attribute: .bottom, relatedBy: .equal, toItem: sideMenuView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: conteinerView, attribute: .left, relatedBy: .equal, toItem: sideMenuView, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: conteinerView, attribute: .right, relatedBy: .equal, toItem: sideMenuView, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
    }
    
    @IBAction func menuButtonAction(_ sender: UIButton) {
        if isSlideMenuHidden{
            SMConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }else{
            SMConstraint.constant = -(UIScreen.main.bounds.width / 2) - 50
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        isSlideMenuHidden = !isSlideMenuHidden 
    }
    
    
    //UICollectionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.iconImage.image = UIImage(named: images[indexPath.section])
        
        return cell
        
    }
    
    //UICollectionView Flow Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainView")
            self.present(storyboard, animated: true, completion: nil)
        }else if indexPath.section == 1{
            let storyboard = UIStoryboard(name: "MainCheckers", bundle: nil).instantiateViewController(withIdentifier: "MainCheckersID")
            self.present(storyboard, animated: true, completion: nil)
        }
    }

}
