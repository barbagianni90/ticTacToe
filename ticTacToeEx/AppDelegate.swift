//
//  AppDelegate.swift
//  ticTacToeEx
//
//  Created by Stefano Apuzzo on 26/03/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit
import Firebase
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
        
    private var reachability: Reachability!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        self.observeReachability()
        
        return true
    }
    
    func observeReachability(){
        
        
        self.reachability = Reachability()
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        do {
            try self.reachability.startNotifier()
        }
        catch(let error) {
            print("Error occured while starting reachability notifications : \(error.localizedDescription)")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
            
        case .cellular:
            
            if MainViewController.user.nickName != "" {
            
                Database.database().reference().child("Players").child("\(MainViewController.user.id)").child("loggato").onDisconnectSetValue("No")
                Database.database().reference().child("Players").child("\(MainViewController.user.id)").child("stato").onDisconnectSetValue("offline")
            }
            break
        case .wifi:
            
            if MainViewController.user.nickName != "" {
                
                Database.database().reference().child("Players").child("\(MainViewController.user.id)").child("loggato").onDisconnectSetValue("No")
                Database.database().reference().child("Players").child("\(MainViewController.user.id)").child("stato").onDisconnectSetValue("offline")
            }
            break
        case .none:
            
            let alert = UIAlertController(title: "Connessione persa", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            let window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = UIViewController()
            window?.windowLevel = UIWindowLevelAlert + 1
            window?.makeKeyAndVisible()
            window?.rootViewController?.present(alert, animated: true, completion: nil)
            
            break
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        print("Enter in ResignActive")
        /*
        if MainViewController.user.nickName != "" {
        
            let uploadData = UIImagePNGRepresentation(MainViewController.user.image!)!
            
            let base64ImageString = uploadData.base64EncodedString()
            
            let ref = Database.database().reference()
            
            ref.child("Players").child("\(MainViewController.user.id)").setValue(
                
                [
                    "nickname" : "\(MainViewController.user.nickName)",
                    "image" : "\(base64ImageString)",
                    "email" : "\(MainViewController.user.email)",
                    "vittorieTris" : "\(MainViewController.user.vittorieTris)",
                    "vittorieDama" : "\(MainViewController.user.vittorieDama)",
                    "sconfitteTris" : "\(MainViewController.user.sconfitteTris)",
                    "sconfitteDama" : "\(MainViewController.user.sconfitteDama)",
                    "stato" : "offline",
                    "invitatoDa" : "",
                    "invitoAccettato" : "",
                    "loggato" : "Pausa"
                ])
        }*/
        self.saveContext()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        print("Enter in Background")
        
        if MainViewController.user.nickName != "" {
            
            let uploadData = UIImagePNGRepresentation(MainViewController.user.image!)!
            
            let base64ImageString = uploadData.base64EncodedString()
            
            let ref = Database.database().reference()
            
            ref.child("Players").child("\(MainViewController.user.id)").setValue(
                
                [
                    "nickname" : "\(MainViewController.user.nickName)",
                    "image" : "\(base64ImageString)",
                    "email" : "\(MainViewController.user.email)",
                    "vittorieTris" : "\(MainViewController.user.vittorieTris)",
                    "vittorieDama" : "\(MainViewController.user.vittorieDama)",
                    "sconfitteTris" : "\(MainViewController.user.sconfitteTris)",
                    "sconfitteDama" : "\(MainViewController.user.sconfitteDama)",
                    "stato" : "offline",
                    "invitatoDa" : "",
                    "invitoAccettato" : "",
                    "loggato" : "Pausa"
                ])
            Database.database().reference().child("Players").child("\(MainViewController.user.id)").child("loggato").onDisconnectSetValue("No")
            Database.database().reference().child("Players").child("\(MainViewController.user.id)").child("stato").onDisconnectSetValue("offline")
        }
        
        self.saveContext()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        /*
        if MainViewController.user.nickName != "" {
        
            let uploadData = UIImagePNGRepresentation(MainViewController.user.image!)!
            
            let base64ImageString = uploadData.base64EncodedString()
            
            let ref = Database.database().reference()
            
            ref.child("Players").child("\(MainViewController.user.id)").setValue(
                
                [
                    "nickname" : "\(MainViewController.user.nickName)",
                    "image" : "\(base64ImageString)",
                    "email" : "\(MainViewController.user.email)",
                    "vittorieTris" : "\(MainViewController.user.vittorieTris)",
                    "vittorieDama" : "\(MainViewController.user.vittorieDama)",
                    "sconfitteTris" : "\(MainViewController.user.sconfitteTris)",
                    "sconfitteDama" : "\(MainViewController.user.sconfitteDama)",
                    "stato" : "online",
                    "invitatoDa" : "",
                    "invitoAccettato" : "",
                    "loggato" : "Si"
                ])
        }*/
        self.saveContext()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        if MainViewController.user.nickName != "" {
        
            let uploadData = UIImagePNGRepresentation(MainViewController.user.image!)!
            
            let base64ImageString = uploadData.base64EncodedString()
            
            let ref = Database.database().reference()
            
            ref.child("Players").child("\(MainViewController.user.id)").setValue(
                
                [
                    "nickname" : "\(MainViewController.user.nickName)",
                    "image" : "\(base64ImageString)",
                    "email" : "\(MainViewController.user.email)",
                    "vittorieTris" : "\(MainViewController.user.vittorieTris)",
                    "vittorieDama" : "\(MainViewController.user.vittorieDama)",
                    "sconfitteTris" : "\(MainViewController.user.sconfitteTris)",
                    "sconfitteDama" : "\(MainViewController.user.sconfitteDama)",
                    "stato" : "online",
                    "invitatoDa" : "",
                    "invitoAccettato" : "",
                    "loggato" : "Si"
                ])
            Database.database().reference().child("Players").child("\(MainViewController.user.id)").child("loggato").onDisconnectSetValue("No")
            Database.database().reference().child("Players").child("\(MainViewController.user.id)").child("stato").onDisconnectSetValue("offline")
        }
        
        self.saveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
       
        self.saveContext()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

