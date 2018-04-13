//
//  SideMenuViewController.swift
//  ticTacToeEx
//
//  Created by Stefano Apuzzo on 11/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit
import Firebase

class SideMenuViewController: UITableViewController {

    @IBOutlet weak var labelSignIn: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if MainViewController.user.nickName == "" {
            
            self.labelSignIn.text = "Sign In"
        }
        else {
            
            self.labelSignIn.text = "Log out"
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
        
    }

    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if indexPath.row == 2 && self.labelSignIn.text as! String == "Sign In"  {
            
            let signInView = UIStoryboard(name: "SignInANDSignUp", bundle: nil).instantiateViewController(withIdentifier: "signIn")
            self.present(signInView, animated: true, completion: nil)
        }
        else if indexPath.row == 2 && self.labelSignIn.text as! String == "Log out" {
            
            do {
                try Auth.auth().signOut()
                MainViewController.user = User()
                self.labelSignIn.text = "Sign In"
            }
            catch {
                
                print("error")
            }
        }
    }
   

}
