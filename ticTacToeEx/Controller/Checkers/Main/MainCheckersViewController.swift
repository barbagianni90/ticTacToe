//
//  MainCheckersViewController.swift
//  ticTacToeEx
//
//  Created by CertimeterGroup on 10/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit


class MainCheckersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func homeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func rankingButton(_ sender: Any) {

        let storyboard = UIStoryboard(name: "RankingDama", bundle: nil).instantiateViewController(withIdentifier: "RankingDama")
        self.present(storyboard, animated: true, completion: nil)
        
    }
    
    
    
    
}
