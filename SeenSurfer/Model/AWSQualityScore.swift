//
//  AWSQualityScore.swift
//  SeenSurfer
//
//  Created by Brett Wright on 2/3/18.
//  Copyright © 2018 brett wright. All rights reserved.
//

import Foundation

class AWSQualityScore: Decodable {
    var Brightness: Double?
    var Sharpness: Double?
    
    init(withDict dict: [String:Any]) {
        if let brightness = dict["Brightness"] as? Double {
            self.Brightness = brightness
        }
        
        if let sharpness = dict["sharpness"] as? Double {
            self.Sharpness = sharpness
        }
    }
}
