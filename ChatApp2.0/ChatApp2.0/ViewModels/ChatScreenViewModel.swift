//
//  ChatScreenViewModel.swift
//  ChatApp2.0
//
//  Created by Shraddha on 27/03/23.
//

import Foundation

class ChatScreenViewModel: ObservableObject{
    @Published var message: [MessageModel] = []
    @Published var sendMessageText = ""
    @Published var chat: ChatModel
    @Published var isTyping = false
    @Published var currentStatus = "Offline"
    init(chat: ChatModel){
        self.chat = chat
    }
    // this function hits api whose response is recieved in the socket
    func showTyping(settings: UserSettings){
        NetworkManager.shared.getChatApi(urlString: "https://api.chatengine.io/chats/", requestFor: "showTyping", self.chat.id, method: "POST", username: settings.user.username, userScret: settings.user.secret, requestInfo: nil, completionHandler: {
            data in
            
        }, errorHandler: {
            data in
        })
    }
    //this function updata my isTyping variable where ever I need to show sender typing
    func updateTyping(settings: UserSettings){
        if self.isTyping != true {
            self.isTyping = true
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.isTyping = false
            }
        }
    }
    
    //this functions start my socket and recieves data
    //it recieves data of three types 1:new message 2: user is typing 3: user is online/offline
    //it also calls userOnline to set the status of current user
    func startSocket(settings: UserSettings) {
        WSManager.shared.setupConnection(chatId: String(chat.id), chatAccessKey: chat.accessKey, completionHandler: { data in
            print(data)
            guard let data = data.toJSON() as? [String: Any] else {return}
            switch ((data["action"] as! String)) {
            case "new_message":
                guard let value = data["data"] as? [String: Any] else {return}
                guard let msg = value["message"] as? [String: Any] else {return}
                if settings.user.username != msg["sender_username"] as? String ?? "User-name" {
                    self.message.append(MessageModel(id: msg["id"] as? Int ?? 0, text: msg["text"] as? String ?? "Text", sender: msg["sender_username"] as? String ?? "Sender", created: msg["created"] as? String ?? "default 12/90/5678"))
                }
            case "is_typing":
                guard let value = data["data"] as? [String: Any] else {return}
                if settings.user.username != value["person"] as! String {
                    self.updateTyping(settings: UserSettings())
                }
            case "edit_chat":
                guard let value = data["data"] as? [String: Any] else {return}
                var people = value["people"] as? [[String: Any]]
                var person1 = people?[0]["person"] as? [String: Any]
                var person2 = people?[1]["person"] as? [String: Any]
                var person: [String: Any]?
                if person1?["username"] as? String == settings.user.username {
                    person = person2
                } else {
                    person = person1
                }
                var isOnline = person?["is_online"] as? Bool
                self.currentStatus = isOnline ?? false ? "Online" : "Offline"
            default:
                break
            }
        })
        self.makeOnline(state: "true", settigns: UserSettings())
    }
//this function is used to send message from textfield of chatScreen, it hits api to post user messages
    func SendMessage(settings: UserSettings){
        if self.sendMessageText.trimmingCharacters(in: .whitespaces).isEmpty{
            return
        }
        NetworkManager.shared.getChatApi(urlString: "https://api.chatengine.io/chats/", requestFor: "chatMessage", self.chat.id, method: "POST", username: settings.user.username, userScret: settings.user.secret, requestInfo: ["text": self.sendMessageText], completionHandler: {
            data in
            guard let data = data as? [String: Any] else {return}
            self.message.append(MessageModel(id: data["id"] as? Int ?? 0, text: data["text"] as? String ?? "DefaultText", sender: data["sender_username"] as? String ?? "DefaultSender", created: data["created"] as? String ?? "11:22"))
            self.sendMessageClear()
        }, errorHandler: {
            data in
        })
    }
    // this function hits api to load messages
    func loadMessages(settings: UserSettings){
        NetworkManager.shared.getChatApi(urlString: "https://api.chatengine.io/chats/", requestFor: "getChatMessage",self.chat.id , method: "GET", username: settings.user.username, userScret: settings.user.secret, requestInfo: nil, completionHandler: {
            data in
            print(data)
            guard let value = data as? [[String:Any]] else {return}
            var tempCurrent: [MessageModel] = []
            let length = value.count
            for temp in value{
                let sender_username = temp["sender_username"] as? String ?? "errorForUsername"
                print(sender_username)
                let created = temp["created"] as? String ?? "errorForCreated"
                print(created)
                let text = temp["text"] as? String ?? "errorForText"
                print(text)
//                    chats.append(ChatMessage(created: created, sender_username: sender_username, text: text))
               tempCurrent.append(MessageModel(id: temp["id"] as? Int ?? 0, text: text, sender: sender_username, created: created))
            }
            self.message = tempCurrent
        }, errorHandler: {
            data in
            
        })
    }
    //this function is used to clear textfield after user sends a message
    func sendMessageClear(){
        sendMessageText = ""
    }
    // this function is made to fetch time from created that is recieved from api
    func getTime(_ date: String) -> String{
        if date.count < 16 {
            return "2000-12-09"
        }
        return String(date[date.index(date.startIndex, offsetBy: 11)...date.index(date.startIndex, offsetBy: 15)])
    }
    // this function is made to fetch data from created that is recieved from api
    func getDate(_ date: String) -> String{
        if date.count < 12 {
            return "2000-12-09"
        }
        return String(date[date.index(date.startIndex, offsetBy: 0)...date.index(date.startIndex, offsetBy: 10)])
    }
    //this function hits the api and add another body of is_onine of user
    func makeOnline(state: String, settigns: UserSettings){
        NetworkManager.shared.getChatApi(urlString: "https://api.chatengine.io/users/me/", requestFor: "makeOnline", self.chat.id, method: "PATCH", username: settigns.user.username, userScret: settigns.user.secret, requestInfo: ["is_online": state], completionHandler: {
            data in
            print(data)
            print("Making user online")
        }, errorHandler: {
            data in
            
        })
    }
    // this function closes the connection of socket and also sets the state of user offline whenever it is called
    func closeConnection() {
        self.makeOnline(state: "false", settigns: UserSettings())
        WSManager.shared.close()
    }
}
// It is converting my string to JSON Object
extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
