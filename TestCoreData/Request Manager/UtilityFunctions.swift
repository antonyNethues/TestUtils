//
//  UtilityFunctions.swift
//  TestCoreData
//
//  Created by Admin on 5/21/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class UtilityFunctions: NSObject {

    let sharedInstance = UtilityFunctions()
    
}


extension Date {
    struct Formatter {
        static let utcFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss'Z'"
            dateFormatter.timeZone = TimeZone(identifier: "GMT")
            
            return dateFormatter
        }()
    }
    
    var dateToUTC: String {
        return Formatter.utcFormatter.string(from: self)
    }
}

extension String {
    struct Formatter {
        static let utcFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssz"
            
            return dateFormatter
        }()
    }
    
    var dateFromUTC: Date? {
        return Formatter.utcFormatter.date(from: self)
    }
}
