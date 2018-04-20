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
        
        if string.range(of: "Tris") != nil {
            
            return "Tris"
        }
        if string.range(of: "Dama") != nil {
            
            return "Dama"
        }
        if string.range(of: "Scacchi") != nil {
            
            return "Scacchi"
        }
        
        return ""
    }
    
    static func extractNickname(_ string: Any) -> String {
        
        let string = string as! String
                
        if string.range(of: "Tris") != nil {
            
            let indexStartStringGame = (string.range(of: "Tris")?.upperBound)!
            
            return String(string.prefix(upTo: indexStartStringGame))
        }
        if string.range(of: "Dama") != nil {
            
            let indexStartStringGame = (string.range(of: "Dama")?.upperBound)!
            
            return String(string.prefix(upTo: indexStartStringGame))
        }
        if string.range(of: "Scacchi") != nil {
            
            let indexStartStringGame = (string.range(of: "Scacchi")?.upperBound)!
            
            return String(string.prefix(upTo: indexStartStringGame))
        }
        
        return ""
    }
}
