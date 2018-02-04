//
//  SeenSurferPerson.swift
//  SeenSurfer
//
//  Created by Brett Wright on 2/4/18.
//  Copyright © 2018 brett wright. All rights reserved.
//

import Foundation

class SeenSurferPerson {
    private var _age: Int?
    private var _mood: AWSEmotion?
    private var _gender: AWSGenderValue?
    private var _isSmiling: Bool?
    
    var age: Int? {
        get {
            return _age
        } set {
            _age = newValue
        }
    }
    
    var mood: AWSEmotion? {
        get {
            return _mood
        } set {
            _mood = newValue
        }
    }
    
    var gender: AWSGenderValue? {
        get {
            return _gender
        } set {
            _gender = newValue
        }
    }
    
    var isSmiling: Bool? {
        get {
            return _isSmiling
        } set {
            _isSmiling = newValue
        }
    }
    
    
}
