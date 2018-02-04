//
//  SeenSurferVenue.swift
//  SeenSurfer
//
//  Created by Brett Wright on 2/3/18.
//  Copyright © 2018 brett wright. All rights reserved.
//

import Foundation

class SeenSurferVenue {
    private var _name: String?
    private var _id: String?
    private var _averageLowAgeRange: Int?
    private var _averageHighAgeRange: Int?
    private var _maleOccupancyPercentage: Double?
    private var _femaleOccupancyPercentage: Double?
    private var _maleOccupancyCount: Double?
    private var _femaleOccupancyCount: Double?
    private var _totalBodyCount: Int?
    private var _vibeRating: Double?
    private var _imageUrl: String?
    
    var name: String? {
        get {
            return _name
        } set {
            _name = newValue
        }
    }
    
    var id: String? {
        get {
            return _id
        } set {
            _id = newValue
        }
    }
    
    var averageLowAgeRange: Int? {
        get {
            return _averageLowAgeRange
        } set {
            _averageLowAgeRange = newValue
        }
    }
    
    var averageHighAgeRange: Int? {
        get {
            return _averageHighAgeRange
        } set {
            _averageHighAgeRange = newValue
        }
    }
    
    
    var maleOccupancyPercentage: Double? {
        get {
            return _maleOccupancyPercentage
        } set {
            _maleOccupancyPercentage = newValue
        }
    }
    
    var femaleOccupancyPercentage: Double? {
        get {
            return _femaleOccupancyPercentage
        } set {
            _femaleOccupancyPercentage = newValue
        }
    }
    
    var maleOccupancyCount: Double? {
        get {
            return _maleOccupancyCount
        } set {
            _maleOccupancyCount = newValue
        }
    }
    
    var femaleOccupancyCount: Double? {
        get {
            return _femaleOccupancyCount
        } set {
            _femaleOccupancyCount = newValue
        }
    }
    
    
    var totalBodyCount: Int? {
        get {
            return _totalBodyCount
        } set {
            _totalBodyCount = newValue
        }
    }
    
    var vibeRating: Double? {
        get {
            return _vibeRating
        } set {
            _vibeRating = newValue
        }
    }
    
    var imageUrl: String? {
        get {
            return _imageUrl
        } set {
            _imageUrl = newValue
        }
    }
    
    init() {

    }
    
    init(withDict dict: [String:Any]) {
        if let name = dict["name"] as? String {
            self.name = name
        }
        
        if let id = dict["id"] as? String {
            self.id = id
        }
        
        if let averageLowAgeRange = dict["averageLowAgeRange"] as? Int {
            self.averageLowAgeRange = averageLowAgeRange
        }
        
        if let averageHighAgeRange = dict["averageHighAgeRange"] as? Int {
            self.averageHighAgeRange = averageHighAgeRange
        }
        
        if let maleOccupancyPercentage = dict["maleOccupancyPercentage"] as? Double {
            self.maleOccupancyPercentage = maleOccupancyPercentage
        }
        
        if let femaleOccupancyPercentage = dict["femaleOccupancyPercentage"] as? Double {
            self.femaleOccupancyPercentage = femaleOccupancyPercentage
        }
        
        if let maleOccupancyCount = dict["maleOccupancyCount"] as? Double {
            self.maleOccupancyCount = maleOccupancyCount
        }
        
        if let femaleOccupancyCount = dict["femaleOccupancyCount"] as? Double {
            self.femaleOccupancyCount = femaleOccupancyCount
        }
        
        if let totalBodyCount = dict["totalBodyCount"] as? Int {
            self.totalBodyCount = totalBodyCount
        }
        
        if let vibeRating = dict["vibeRating"] as? Double {
            self.vibeRating = vibeRating
        }
        
        if let imageUrl = dict["imageUrl"] as? String {
            self.imageUrl = imageUrl
        }
        
    }
    
    
}
