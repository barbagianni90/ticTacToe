//
//  StartViewController.swift
//  ticTacToeEx
//
//  Created by Stefano Apuzzo on 09/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var signInButton: UIButton!
    
    
    @IBAction func signInButton(_ sender: Any) {
        
        let signInView = UIStoryboard(name: "SignInANDSignUp", bundle: nil).instantiateViewController(withIdentifier: "signIn")
        self.present(signInView, animated: true, completion: nil)
    }
    
    var images = ["iconTris", "SecondoAvatar"]
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let inset: CGFloat = (UIScreen.main.bounds.width / 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //CollectionView Setting
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView?.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 100, left: inset - 50, bottom: 0, right: inset - 50)
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.minimumLineSpacing = 60
        
        collectionView.backgroundColor = UIColor.darkGray
        
        collectionView.delegate = self
        collectionView.dataSource = self
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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainView")
        self.present(storyboard, animated: true, completion: nil)
    }
}
