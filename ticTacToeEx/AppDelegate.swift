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
        // Override point for customization after application launch.
        
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
            
//            let alert = UIAlertController(title: "Riconnesso", message: nil, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            
            break
        case .wifi:
            
//            let alert = UIAlertController(title: "Riconnesso", message: nil, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            
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
                "loggato" : "No"
            ])
        self.saveContext()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
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
                "loggato" : "No"
            ])
        self.saveContext()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
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
        self.saveContext()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
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
                "loggato" : "No"
            ])
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

