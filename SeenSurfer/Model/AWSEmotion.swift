//
//  AWSEmotion.swift
//  
//
//  Created by Brett Wright on 2/3/18.
//

import Foundation

class AWSEmotion: Decodable {
    var `Type`: String? // Backticks needed since type is a keyword
    var Confidence: Double?
    
    init(withDict dict: [String:Any]) {
        if let type = dict["Type"] as? String {
            self.Type = type
        }
        
        if let confidence = dict["Confidence"] as? Double {
            self.Confidence = confidence
        }
    }
}

enum AWSEmotionType: String, Decodable {
    case happy = "HAPPY"
    case calm = "CALM"
    case angry = "ANGRY"
}

