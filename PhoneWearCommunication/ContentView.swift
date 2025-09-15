//
//  ContentView.swift
//  PhoneWearCommunication
//
//  Created by Gaurav Tak on 15/09/25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText = ""
    @ObservedObject var connectivity = ConnectivityProvider.shared
    
    var body: some View {
        VStack(spacing: 20) {
            Text("📱 Phone ↔ Watch Communication")
                .font(.headline)
            
            TextField("Enter message", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Send to Watch ⌚") {
                connectivity.send(message: inputText)
                inputText = ""
            }
            .buttonStyle(.borderedProminent)
            
            Text("Sent: \(connectivity.sentMessage)")
            Text("Received: \(connectivity.receivedMessage)")
        }
        .padding()
    }
}

