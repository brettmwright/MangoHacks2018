//
//  AWSSmile.swift
//  SeenSurfer
//
//  Created by Brett Wright on 2/3/18.
//  Copyright © 2018 brett wright. All rights reserved.
//

import Foundation

class AWSSmile: Decodable {
    var Value: Bool?
    var Confidence: Double?
    
    init(withDict dict: [String:Any]) {
        if let value = dict["Value"] as? Bool {
            self.Value = value
        }
        
        if let confidence = dict["confidence"] as? Double {
            self.Confidence = confidence
        }
    }
}
