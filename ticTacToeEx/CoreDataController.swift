//
//  CoreDataController.swift
//  ticTacToeEx
//
//  Created by CertimeterGroup on 27/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import UIKit
import CoreData


class CoreDataController: NSObject {
    
    //restituisce il context in uso
    private class func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    //salva i dati del nuovo user
    class func addRemindUser(mail: String, password: String ){
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "RemindUser", in: context)
        
        let newUser = RemindUser(entity: entity!, insertInto: context)
        
        newUser.mail = mail
        newUser.pass = password
        
        do{
            try context.save()
        }catch{
            print("Errore salvataggio User: \(String(describing: newUser.mail)) \n")
        }
        print("Salvataggio riuscito\n")
    }
    
    //Restituisce tutti gli utenti salvati
    class func fetchRemindUser() -> RemindUser?{
        let context = getContext()
        var user: [RemindUser]? = nil
        do{
            user = try context.fetch(RemindUser.fetchRequest())
            
            
            if user!.count > 0{
                
                for i in user!{
                    print("\n\n***\n\(String(describing: i.mail))\n\(i.pass)\n***\n\n")
                }
                
                return user?[0]
            }
            return nil
        }catch{
            print("Errore caricamento utenti..\n")
            return nil
        }
    }
    
    //salva il context utilizzato
    class func saveContext(){
        let context = getContext()
        do{
            try context.save()
        }catch{
            print("Errore salvataggio context\n")
        }
        print("Cambiamenti salvati")
    }
    
    
}
