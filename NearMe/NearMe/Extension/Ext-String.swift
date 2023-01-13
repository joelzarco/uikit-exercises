//
//  Ext-String.swift
//  NearMe
//
//  Created by Johel Zarco on 13/01/23.
//

import Foundation

extension String{
    var formatPhoneNumber : String{
        self.replacingOccurrences(of: " ", with: "")
        self.replacingOccurrences(of: "+", with: "")
        self.replacingOccurrences(of: "(", with: "")
        self.replacingOccurrences(of: ")", with: "")
        self.replacingOccurrences(of: "-", with: "")
        return self
    }
}
