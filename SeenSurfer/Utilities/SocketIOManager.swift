//
//  SocketManager.swift
//  SeenSurfer
//
//  Created by Brett Wright on 2/3/18.
//  Copyright © 2018 brett wright. All rights reserved.
//

import Foundation
import SocketIO

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
    
    func connectToCamera() {
        guard let _socket = socket else { return }
        //_socket.emit("cam", "")

        _socket.on("sceneUpdate") {data, ack in
            guard let stream = data as? [[String: Any]] else { return }

            print("Data: ", stream)
        }
    }
    
//    func connectToCamera(completionHandler: (_ data: Data) -> Void) {
//        guard let _socket = socket else { return }
//        _socket.emit("cam", "")
//
//        _socket.on("camStream") {data, ack in
//            guard let stream = data[0]["Payload"] as? Data else { return }
//            print("Data: ", stream)
//            completionHandler(data: stream)
//        }
//
//    }
    
    func establishConnection() {
        guard let _socket = socket else { return }
        _socket.connect()
    }
    
    
    func closeConnection() {
        guard let _socket = socket else { return }
        _socket.disconnect()
    }
    
}

