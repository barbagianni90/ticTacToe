//
//  ConvertOptionalString.swift
//  ticTacToeEx
//
//  Created by Mac Luca on 19/04/18.
//  Copyright © 2018 Stefano Apuzzo. All rights reserved.
//

import Foundation

class ConvertOptionalString {
    
    static func convert(_ string: Any) -> String {
        
        return string as! String
    }
    
    static func extractNameGame(_ string: Any) -> String {
        
        let string = string as! String
        
        if string.range(of: "tris") != nil {
            
            return "tris"
        }
        if string.range(of: "dama") != nil {
            
            return "dama"
        }
        if string.range(of: "scacchi") != nil {
            
            return "scacchi"
        }
        
        return ""
    }
    
    static func extractNickname(_ string: Any) -> String {
        
        let string = string as! String
                
        if string.range(of: "tris") != nil {
            
            let indexStartStringGame = (string.range(of: "tris")?.lowerBound)!
            
            return String(string.prefix(upTo: indexStartStringGame))
        }
        if string.range(of: "dama") != nil {
            
            let indexStartStringGame = (string.range(of: "dama")?.lowerBound)!
            
            return String(string.prefix(upTo: indexStartStringGame))
        }
        if string.range(of: "scacchi") != nil {
            
            let indexStartStringGame = (string.range(of: "scacchi")?.lowerBound)!
            
            return String(string.prefix(upTo: indexStartStringGame))
        }
        
        return ""
    }
}
