//
//  AWSGender.swift
//  SeenSurfer
//
//  Created by Brett Wright on 2/3/18.
//  Copyright © 2018 brett wright. All rights reserved.
//

import Foundation

class AWSGender: Decodable {
    var Value: String?
    var Confidence: Double?
    
    init(withDict dict: [String:Any]) {
        if let value = dict["Value"] as? String {
            self.Value = value
        }
        
        if let confidence = dict["Confidence"] as? Double {
            self.Confidence = confidence
        }
    }
}

enum AWSGenderValue: String, Decodable {
    case female = "Female"
    case male = "Male"
}
