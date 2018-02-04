//
//  SeenSurferResult.swift
//  SeenSurfer
//
//  Created by Brett Wright on 2/3/18.
//  Copyright © 2018 brett wright. All rights reserved.
//

import Foundation

class SeenSurferResult: Decodable {
    var ai: AWSFacialAnalysisResult?
    var sceneId: String?
    
    
    init(withDict dict: [String:Any]) {
        if let aiDict = dict["ai"] as? [String:Any] {
            self.ai = AWSFacialAnalysisResult(withDict: aiDict)
        }
        
        if let sceneId = dict["sceneId"] as? String {
            self.sceneId = sceneId
        }
    }
}
