//
//  String+Extension.swift
//  CoolBudget
//
//  Created by Johel Zarco on 16/01/23.
//

import Foundation

extension String{
    // methods for validating budget textFields
    
    var isNumeric : Bool{
        return Double(self) != nil
    }
    
    func isGreaterThan(_ value : Double) -> Bool{
        guard self.isNumeric else { return false }
        return Double(self)! > value
    }
    
}
