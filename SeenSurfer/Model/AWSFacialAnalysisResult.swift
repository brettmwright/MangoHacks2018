//
//  AWSFacialAnalysisResult.swift
//  SeenSurfer
//
//  Created by Brett Wright on 2/3/18.
//  Copyright © 2018 brett wright. All rights reserved.
//

import Foundation

class AWSFacialAnalysisResult: Decodable {
    var FaceDetails: [AWSFaceDetail]?
    
    init(withDict dict: [String:Any]) {
        if let faceDetails = dict["FaceDetails"] as? [[String:Any]] {
            self.FaceDetails = []
            for faceDetail in faceDetails {
                let faceDetailObj = AWSFaceDetail(withDict: faceDetail)
                self.FaceDetails?.append(faceDetailObj)
            }
            
        }
    }
}

