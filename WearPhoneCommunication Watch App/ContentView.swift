//
//  ContentView.swift
//  WearPhoneCommunication Watch App
//
//  Created by Gaurav Tak on 15/09/25.
//

import SwiftUI

struct WatchContentView: View {
    @State private var inputText = ""
    @ObservedObject var connectivity = WatchConnectivityProvider.shared
    
    var body: some View {
        VStack(spacing: 10) {
            Text("⌚ Watch Communication")
                .font(.headline)
            
            TextField("Message", text: $inputText)
            
            Button("Send to Phone 📱") {
                connectivity.send(message: inputText)
                inputText = ""
            }
            .buttonStyle(.bordered)
            
            Text("Sent: \(connectivity.sentMessage)")
                .font(.footnote)
            Text("Received: \(connectivity.receivedMessage)")
                .font(.footnote)
        }
        .padding()
    }
}

