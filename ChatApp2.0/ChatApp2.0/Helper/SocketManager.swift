//
//  SocketManager.swift
//  ChatApp2.0
//
//  Created by Shraddha on 29/03/23.
//

import Foundation
import SwiftUI

enum SocketRequest: String {
    case typing = "is_typing"
    case recievedMsg = "new_message"
}

class WSManager: NSObject, URLSessionWebSocketDelegate {
    static let shared = WSManager()
    private var webSocket: URLSessionWebSocketTask?
    var completionHandler: ((String)->())?
    //this function intialise completionHandler class variable and sets up the socket
    func setupConnection(chatId: String, chatAccessKey: String, completionHandler: @escaping ((String)->())) {
        self.completionHandler = completionHandler
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let url = URL(string: "wss://api.chatengine.io/chat/?projectID=\(ProjectSettings.projectId)&chatID=\(chatId)&accessKey=\(chatAccessKey)")
        webSocket = session.webSocketTask(with: url!)
        webSocket?.resume()
    }
    //for testing if socket is working perfectly
    func ping() {
        webSocket?.sendPing(pongReceiveHandler: { error in
            if let error = error {
                print("Ping error: \(error)")
            }
        })
    }
    //for closing the socket
    func close() {
        webSocket?.cancel(with: .goingAway, reason: "Gone".data(using: .utf8))
    }
    
    func send() {
        webSocket?.send(.string("Message from Ashish"), completionHandler: { error in
            if let error = error {
                print("Send error: \(error)")
            } else {
                print("Msg sent successfully")
            }
        })
    }
    //if the result is recieved the completion handler is called using recursion
    func recieve() {
        webSocket?.receive(completionHandler: { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .data(let data):
                    print("Got data: \(data)")
                case .string(let message):
                    self!.completionHandler!(message)
                @unknown default:
                    print("Default")
                    break
                }
                
            case .failure(let error):
                print("Receive Error: \(error)")
            }
            self?.recieve()
        })
    }
    //this function is called when socket session is started
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Connection Established")
        ping()
        recieve()
    }
    //this function is called when socket session is ended
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Connection Terminated")
    }
}
