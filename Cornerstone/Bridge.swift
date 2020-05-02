//
//  Bridge.swift
//  Cornerstone
//
//  Created by Simon Raboczi on 27/3/20.
//  Copyright © 2020 Simon Raboczi. All rights reserved.
//

import Foundation

// MARK: - OSGi events over WebSockets

//let ServerWebSocketURL = URL(string: "wss://raboczi.id.au/example-websocket")!
let ServerWebSocketURL = URL(string: "ws://radiostar.local:8181/example-websocket")!
let TestServiceNotificationName = NSNotification.Name(rawValue: "au/id/raboczi/cornerstone/test_service/EVENT")

/// Bridge between NotificationCenter events and OSGi events over WebSocket
class Bridge {
    
    private var webSocketTask: URLSessionWebSocketTask?
    
    func start() {
        let urlSession = URLSession(configuration: .default)
        webSocketTask = urlSession.webSocketTask(with: ServerWebSocketURL)
        guard let webSocketTask = webSocketTask else { fatalError("Oops") }
        receiveMessage(webSocketTask: webSocketTask)
        webSocketTask.resume()
    }
    
    func stop() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
    
    private func receiveMessage(webSocketTask: URLSessionWebSocketTask) {
        webSocketTask.receive { result in
            switch result {
            case .failure(let error):
                print("Error in receiving message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    NotificationCenter.default.post(name: TestServiceNotificationName, object: text)
                case .data(let data):
                    print("Received data: \(data)")
                @unknown default:
                    fatalError("Unrecognized message \(message)")
                }
                
                self.receiveMessage(webSocketTask: webSocketTask)
            }
        }
    }
}
