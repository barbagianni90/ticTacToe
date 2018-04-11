//
//  ContainerViewController.swift
//  ticTacToeEx
//
//  Created by Stefano Apuzzo on 11/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
            NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("toggleSideMenu"), object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    
    var sideMenuOpen = false
    
    @objc func toggleSideMenu() {
        
        if sideMenuOpen {
            sideMenuOpen = false
            sideMenuConstraint.constant = -240
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            
            
        } else {
            sideMenuOpen = true
            sideMenuConstraint.constant = -50
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            
        }
        
    }

}
