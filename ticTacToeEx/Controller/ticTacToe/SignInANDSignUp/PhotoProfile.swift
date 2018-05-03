//
//  PhotoProfile.swift
//  ticTacToeEx
//
//  Created by Mac Luca on 04/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit

class PhotoProfile: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
    }
    @IBOutlet weak var camera: UIButton!
    
    @IBOutlet weak var library: UIButton!
    
    @IBOutlet weak var image: UIImageView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraAction(_ sender: UIButton) {
        
        picker.sourceType = .camera
        
        present(picker, animated: true, completion: nil)
    }
    @IBAction func libraryAction(_ sender: UIButton) {
        
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func saveImage(_ sender: UIButton) {
        
        EditProfileViewController.imageSelected = self.image.image
        SignUpViewController.imageProfileSelected = self.image.image
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.image.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
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
