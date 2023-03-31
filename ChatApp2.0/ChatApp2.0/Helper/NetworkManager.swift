//
//  NetworkManager.swift
//  ChatApp2.0
//
//  Created by Shraddha on 26/03/23.
//

import Foundation

import Foundation
import UIKit

struct CreateChat: Encodable {
    var usernames: [String]
    var title: String
    var is_direct_chat = true
    
    init(usernames: [String], title: String) {
        self.usernames = usernames
        self.title = title
    }
}
class NetworkManager {
    static let shared = NetworkManager()
    func requestForApi(urlString: String, _ register: RegisterModel?, method:String ,completionHandler: ((Any)->())?, errorHandler: ((Any)->())?) {
        var request = URLRequest(url: URL(string: urlString)!)
        request.addValue("8b76bfc4-2b1e-47cf-abcc-e99858ea7ee2", forHTTPHeaderField: "PRIVATE-KEY")
        request.httpMethod = method
        if let register = register {
            request.httpBody = try? JSONEncoder().encode(register)
        }
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request) {data, response, err in
            if let err = err {
                print("Received some error in api \(err.localizedDescription)")
                return
            }
            guard let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) else {
                print("Getting some error on json Sericliaxation")
                return
            }
//            print(jsonData)
            DispatchQueue.main.sync {
                completionHandler?(jsonData)
            }
            print("Entered the completionHandler")
        }.resume()
    }
    func getChatApi(urlString: String,requestFor: String,_ chatId: Int, method:String,username: String,userScret: String, requestInfo: [String: String]? ,completionHandler: ((Any)->())?, errorHandler: ((Any)->())?){
        var tempURL: String
        if requestFor == "chatMessage"{
            tempURL = urlString + String(chatId) + "/messages/"
            print(tempURL)
        } else if requestFor == "getChatMessage"{
            tempURL = urlString + String(chatId) + "/messages/"
            print(tempURL)
        }else if requestFor == "showTyping"{
            tempURL = urlString + String(chatId) + "/typing/"
        }
        else{
            tempURL = urlString
        }
        var request = URLRequest(url: URL(string: tempURL)!)
//        if(urlString == "https://retoolapi.dev/5DddMe/data"){
//            request.fetchli
//        }
        request.addValue("5f74b2c6-3249-4f9f-ac3d-42ace94ba53b", forHTTPHeaderField: "Project-ID")
        request.addValue(username, forHTTPHeaderField: "User-Name")
        request.addValue(userScret, forHTTPHeaderField: "User-Secret")
        request.httpMethod = method
        if requestFor == "chatMessage"{
            request.httpBody  = try! JSONEncoder().encode(requestInfo)
        }else if requestFor == "chatBot"{
            request.httpBody  = try! JSONEncoder().encode(requestInfo)
        }
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request) {data, response, err in
            if let err = err {
                print("Received some error in api \(err.localizedDescription)")
                return
            }
            guard let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) else {
                print("Getting some error on json Sericliaxation")
                return
            }
//            print(jsonData)
            DispatchQueue.main.sync {
                completionHandler?(jsonData)
            }
            print("Entered the completionHandler")
        }.resume()
    }
    func createChat(urlString: String, createChat: CreateChat, username: String, userSecret: String, completionHandler: ((Any)->())?, errorHandler: ((Any)->())?) {
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "PUT"
        request.httpBody = try? JSONEncoder().encode(createChat)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("5f74b2c6-3249-4f9f-ac3d-42ace94ba53b", forHTTPHeaderField: "Project-ID")
        request.addValue(username, forHTTPHeaderField: "User-Name")
        request.addValue(userSecret, forHTTPHeaderField: "User-Secret")
        let session = URLSession.shared
        session.dataTask(with: request) {data, response, err in
            if let err = err {
                print("Received some error in api \(err.localizedDescription)")
                return
            }
            guard let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) else {
                print("Getting some error on json Sericliaxation")
                return
            }
            DispatchQueue.main.sync {
                completionHandler?(jsonData)
            }
        }.resume()
    }
}
