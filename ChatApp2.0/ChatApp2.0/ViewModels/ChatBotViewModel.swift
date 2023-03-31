//
//  ChatBotViewModel.swift
//  ChatApp2.0
//
//  Created by Shraddha on 28/03/23.
//

import Foundation
import SwiftUI

class ChatBotViewModel: ObservableObject{
    var temp = ChatModel(id: 1, sender: "DefaultSender", receiver: "DefaultReciever", title: "DefaultTitle", accessKey: "121", lastMessage: "tempMessage", created: "12/23/23")
    var chatTitle = "DefaultTitle"
    @Published var chat: ChatModel?
    @Published var botQuestions: [ChatBotModel] = []
    @Published var showChatScreen = false
    var allQuestions: FetchedResults<BotQuestions>?
    func showBotQuestions(allQuestions: FetchedResults<BotQuestions>){
        self.allQuestions = allQuestions
        botQuestions = []
        let ques = loadQuestions(parentId: nil)
        for temp in ques{
            botQuestions.append(ChatBotModel(id: temp.id!,parentId: temp.parentId, botQue: temp.botQue!))
        }
    }
    func loadQuestions(parentId: UUID?) -> [FetchedResults<BotQuestions>.Element]{
        let temp = allQuestions!.filter{
            que in
            return que.parentId == parentId
        }
        return temp
    }
    func continueProcess(question: ChatBotModel){
        if question.pressed{
            let ques = loadQuestions(parentId: question.id)
            if ques.count != 0 {
                botQuestions.append(ChatBotModel(id: UUID(),parentId: UUID(), botQue: question.botQue, pressed: false))
                chatTitle = question.botQue
            }
            for que in  ques{
                botQuestions.append(ChatBotModel(id: que.id!,parentId: que.parentId, botQue: que.botQue!))
            }
        }
    }
    func createChatRoom(settings: UserSettings){
        NetworkManager.shared.createChat(urlString: "https://api.chatengine.io/chats/", createChat: CreateChat(usernames: [settings.user.username == ChatRoom.user1 ? ChatRoom.user2 : ChatRoom.user1], title: chatTitle), username: settings.user.username, userSecret: settings.user.secret, completionHandler: { data in
            print(data)
            guard let value = data as? [String: Any] else {return}
            let admin = value["admin"] as? [String: Any]
            let sender = admin?["username"] as? String ?? "Sender"
            let people = value["people"] as? [[String: Any]]
            let sam = people?[0] as? [String: Any]
            let person = sam?["person"] as? [String: Any]
            let receiver = person?["username"] as? String ?? "Receiver"
            let title = self.chatTitle
//            let title = value["title"] as? String ?? "DefaultTitle"
            let id = value["id"] as? Int ?? 0
            let accessKey = value["access_key"] as? String ?? "8"
            let lastMessageDetails = value["last_message"] as? [String: Any]
            var lastMessage = lastMessageDetails?["text"] as? String ?? "DefaultMessages"
            lastMessage = lastMessage.count == 0 ? "NoMessage" : lastMessage
            let created = lastMessageDetails?["created"] as? String ?? "DefaultCreated"
            let is_online = person?["is_online"] as? Bool ?? false
            self.chat = ChatModel(id: id, sender: sender, receiver: receiver, title: title, accessKey: accessKey, lastMessage: lastMessage, created: created)
            self.showChatScreen = true
        }, errorHandler: {
            data in
            
        })
    }
    
}
