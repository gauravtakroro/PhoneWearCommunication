//
//  WatchConnectivityProvider.swift
//  PhoneWearCommunication
//
//  Created by Gaurav Tak on 15/09/25.
//


import Foundation
import WatchConnectivity

class WatchConnectivityProvider: NSObject, ObservableObject, WCSessionDelegate {
    static let shared = WatchConnectivityProvider()
    
    @Published var receivedMessage: String = ""
    @Published var sentMessage: String = ""
    
    override private init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    func send(message: String) {
        sentMessage = message
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(["text": message], replyHandler: nil, errorHandler: nil)
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let text = message["text"] as? String {
                self.receivedMessage = text
            }
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
}
