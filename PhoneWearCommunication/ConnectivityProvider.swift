//
//  ConnectivityProvider.swift
//  PhoneWearCommunication
//
//  Created by Gaurav Tak on 15/09/25.
//


import Foundation
import WatchConnectivity

class ConnectivityProvider: NSObject, ObservableObject, WCSessionDelegate {
    static let shared = ConnectivityProvider()
    
    @Published var receivedMessage: String = ""
    @Published var sentMessage: String = ""
    
    override private init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    // Send message to Watch
    func send(message: String) {
        sentMessage = message
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(["text": message], replyHandler: nil, errorHandler: nil)
        }
    }
    
    // Receive message from Watch
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let text = message["text"] as? String {
                self.receivedMessage = text
            }
        }
    }
    
    // Required delegate stubs
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {}
}
