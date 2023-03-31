//
//  ChatScreen.swift
//  ChatApp2.0
//
//  Created by Shraddha on 27/03/23.
//

import SwiftUI

struct ChatScreen: View {
    @ObservedObject var chatScreenVm: ChatScreenViewModel
    @State private var sendMessage = ""
    @EnvironmentObject private var settings: UserSettings
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("Secondary"), Color("Secondary")]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            VStack{
                ScrollView{
                    ScrollViewReader{ value in
                        ForEach(chatScreenVm.message, id: \.id){ text in
                            HStack{
                                if text.sender == settings.user.username{
                                    Spacer()
                                }
                                CustomMessageText(sender: text.sender == settings.user.username, message: text.text, created: chatScreenVm.getTime(text.created)).padding(.vertical, 6)
                                if text.sender != settings.user.username{
                                    Spacer()
                                }
                            }.onAppear(){
                                value.scrollTo(chatScreenVm.message[chatScreenVm.message.count - 1].id)
                            }
                        }
                        
                    }
                }.padding(.top, UIApplication.shared.windows.first!.safeAreaInsets.top )
                HStack{
                    TextField("Write a message", text: $chatScreenVm.sendMessageText).font(.title3).onSubmit {
                        chatScreenVm.SendMessage(settings: settings)
                    }.onChange(of: chatScreenVm.sendMessageText){
                        data in
                        chatScreenVm.showTyping(settings: settings)
                    }
                    Button(action: {
                        chatScreenVm.SendMessage(settings: settings)
                    }, label: {
                        Image(systemName: "paperplane.circle.fill").font(.system(size: 55))
                    })
                }.padding(.vertical, 10).padding(.leading, 16).padding(.trailing, 2).background(.white).cornerRadius(50)
            }.padding(.horizontal, 24).onAppear(){
                chatScreenVm.startSocket(settings: settings)
                chatScreenVm.loadMessages(settings: settings)
                
            }.onDisappear(){
                chatScreenVm.closeConnection()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    VStack{
                        Text(chatScreenVm.chat.title)
                        Text(chatScreenVm.isTyping ? "typing..." : chatScreenVm.currentStatus)
                    }.frame(width: UIScreen.main.bounds.width)
                }
            }
        }
    }
}

//struct ChatScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatScreen(chatScreenVm: ChatScreenViewModel(chat: ChatModel(id: 1, sender: "Shraddha", receiver: "Ashish", title: "Title", accessKey: "wed", lastMessage: "Naaa", created: "05:34"), user: User(username: "Shraddha", firstname: "Jaiswal", lastname: "", secret: <#T##String#>, is_online: <#T##Bool#>)))
//            .environmentObject(UserSettings())
//    }
//}
