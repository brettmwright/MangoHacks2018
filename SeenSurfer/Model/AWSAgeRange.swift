//
//  AWSAgeRange.swift
//  SeenSurfer
//
//  Created by Brett Wright on 2/3/18.
//  Copyright © 2018 brett wright. All rights reserved.
//

import Foundation

class AWSAgeRange: Decodable {
    var Low: Int?
    var High: Int?
    
    init(withDict dict: [String:Any]) {
        if let low = dict["Low"] as? Int {
            self.Low = low
        }
        
        if let high = dict["High"] as? Int {
            self.High = high
        }
    }
}
