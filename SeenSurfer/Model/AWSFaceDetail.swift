//
//  AWSFaceDetail.swift
//  SeenSurfer
//
//  Created by Brett Wright on 2/3/18.
//  Copyright © 2018 brett wright. All rights reserved.
//

import Foundation

class AWSFaceDetail: Decodable {
    var AgeRange: AWSAgeRange?
    var Smile: AWSSmile?
    var Gender: AWSGender?
    var Emotions: [AWSEmotion]?
    var Quality: AWSQualityScore?
    var Confidence: Double?
    
    init(withDict dict: [String:Any]) {
        if let ageRangeDict = dict["AgeRange"] as? [String:Any] {
            self.AgeRange = AWSAgeRange(withDict: ageRangeDict)
        }
        
        if let smileDict = dict["Smile"] as? [String:Any] {
            self.Smile = AWSSmile(withDict: smileDict)
        }
        
        if let genderDict = dict["Gender"] as? [String:Any] {
            self.Gender = AWSGender(withDict: genderDict)
        }
        
        if let emotions = dict["Emotions"] as? [[String:Any]] {
            self.Emotions = []
            for emotion in emotions {
                let newEmotionObj = AWSEmotion(withDict: emotion)
                self.Emotions?.append(newEmotionObj)
            }
        }
        
        if let qualityDict = dict["Quality"] as? [String:Any] {
            self.Quality = AWSQualityScore(withDict: qualityDict)
        }
        
        if let confidence = dict["Confidence"] as? Double {
            self.Confidence = confidence
        }
    }
}
