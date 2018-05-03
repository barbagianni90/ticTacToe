//
//  NewMainViewController.swift
//  ticTacToeEx
//
//  Created by Stefano Apuzzo on 04/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import Foundation
import UIKit

class NewMainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
 
    @IBOutlet  private weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let width = (view.frame.size.width - 20) / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let ticTacToeView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainView")
        self.present(ticTacToeView, animated: true, completion: nil)
    }

    
    
    
}
