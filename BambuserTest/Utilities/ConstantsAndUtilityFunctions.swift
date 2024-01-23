//
//  UtilityAndConstants.swift
//  BambuserTest
//
//  Created by test on 22/01/2024.
//

import UIKit

class ConstantsAndUtilityFunctions: NSObject {
    
    static let HTTP_ERROR: String = "Http Error"
    
    class func dateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat="MMM d, y"
        return dateFormatter.string (from: date)
    }
    
}
