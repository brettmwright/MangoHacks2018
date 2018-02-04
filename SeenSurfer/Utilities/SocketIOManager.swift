//
//  SocketManager.swift
//  SeenSurfer
//
//  Created by Brett Wright on 2/3/18.
//  Copyright © 2018 brett wright. All rights reserved.
//

import Foundation
import SocketIO
import SwiftyJSON

class SocketIOManager: NSObject {
    static let shared = SocketIOManager()
    
    var manager: SocketManager?
    var socket: SocketIOClient?
    
    override init() {
        super.init()
        guard let url = URL(string: "http://54.89.180.9:8080") else { return }
        manager = SocketManager(socketURL: url, config: [.log(true), .compress])
        guard let _manager = manager else { return }
        socket = _manager.defaultSocket
    }
    
    func retrieveVenueUpdates(completionHandler: @escaping (_ awsDataArray: [AWSFaceDetail]) -> Void) {
        guard let _socket = socket else { return }
        _socket.on("sceneUpdate") {data, ack in
            guard let dataDict = data[0] as? [String:Any] else { return }
            print(dataDict)
            let result = SeenSurferResult(withDict: dataDict)
            guard let faceDetails = result.ai?.FaceDetails else { return }
            for faceDetail in faceDetails {
                print("___________")
                print(faceDetail.Gender?.Value)
                print("___________")
            }
            completionHandler(faceDetails)
        }
    }
    
    func establishConnection() {
        guard let _socket = socket else { return }
        _socket.connect()
    }
    
    
    func closeConnection() {
        guard let _socket = socket else { return }
        _socket.disconnect()
    }
    
}

