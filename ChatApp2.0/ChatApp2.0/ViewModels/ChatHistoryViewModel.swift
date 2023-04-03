//
//  ChatHistoryViewModel.swift
//  ChatApp2.0
//
//  Created by Shraddha on 27/03/23.
//

import Foundation
import SwiftUI

class ChatHistoryViewModel: ObservableObject{
    @Published var chat: [ChatModel] = []
    @Published var showNewBotView = false
    @Published var showLogoutAlert = false
    func setUpApp(questions: FetchedResults<BotQuestions> , settings: UserSettings) {
        showChatHistory(questions: questions, settings: settings)
    }
    func showChatHistory(questions: FetchedResults<BotQuestions> ,settings: UserSettings){
        if(questions.count == 0){
            CoreDataHelper.saveExistingQuestions()
        }
        NetworkManager.shared.getChatApi(urlString: "https://api.chatengine.io/chats/", requestFor: "showChatHistory", 111, method: "GET", username: settings.user.username, userScret: settings.user.secret, requestInfo: nil, completionHandler: {
            data in
            guard let data = data as? [[String:Any]] else {return}
            var tempChats: [ChatModel] = []
            for value in data{
                let admin = value["admin"] as? [String: Any]
                let sender = admin?["username"] as? String ?? "Sender"
                let people = value["people"] as? [[String: Any]]
                let temp = people?[0] as? [String: Any]
                let person = temp?["person"] as? [String: Any]
                let receiver = person?["username"] as? String ?? "Receiver"
                let id = value["id"] as? Int ?? 0
                let accessKey = value["access_key"] as? String ?? "1"
                let title = value["title"] as? String ?? "DefaultTitle"
                let lastDetails = value["last_message"] as? [String: Any]
                let lastMessage = lastDetails?["text"] as? String ?? "DefaultMessage"
                let created = lastDetails?["created"] as? String ?? "2000-12-09 08:08z676876"
                let is_online = person?["is_online"] as? Bool ?? false
                tempChats.append(ChatModel(id: id, sender: sender, receiver: receiver, title: title, accessKey: accessKey, lastMessage: lastMessage, created: created))
            }
            self.chat = tempChats
        }, errorHandler: {
            data in
            
        })
    }
    func getTime(_ date: String) -> String{
        if date.count < 16 {
            return "2000-12-09"
        }
        return String(date[date.index(date.startIndex, offsetBy: 11)...date.index(date.startIndex, offsetBy: 15)])
    }
    func getDate(_ date: String) -> String{
        print(date)
        if date.count < 12 {
            return "2000-12-09"
        }
        return String(date[date.index(date.startIndex, offsetBy: 0)...date.index(date.startIndex, offsetBy: 10)])
    }
    func logOut(settings: UserSettings){
        settings.settingUser(user: User(username: "", firstname: "", lastname: "", secret: ""))
    }
}
 
