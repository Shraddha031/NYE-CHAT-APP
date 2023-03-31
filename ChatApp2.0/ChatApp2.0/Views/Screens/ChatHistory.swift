//
//  ChatHistory.swift
//  ChatApp2.0
//
//  Created by Shraddha on 26/03/23.
//

import SwiftUI

struct ChatHistory: View {
    @EnvironmentObject private var settings: UserSettings
    @StateObject private var ChatHistoryVm = ChatHistoryViewModel()
    @State private var searchDetails = ""
    @FetchRequest(sortDescriptors: [SortDescriptor(\.created)]) var botQuery: FetchedResults<BotQuestions>
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("Primary"), .white]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Image(systemName: "magnifyingglass").font(.title2)
                    TextField("Search", text:$searchDetails).textInputAutocapitalization(.never).autocorrectionDisabled()
                }.padding(13)
                    .background(.white)
                    .cornerRadius(12)
                    .shadow(color:Color(hue: 1.0, saturation: 0.0, brightness: 0.88),radius:10)
                    .padding(.horizontal).padding(.top).padding(.bottom, 4)
                Spacer()
                if ChatHistoryVm.chat.count == 0{
                    VStack{
                        Text("No Chats Availabe")
                            .font(.title2)
                            .fontWeight(.medium)
                    }.padding(110).background().cornerRadius(20)
                    
                }
                else{
                    ScrollView{
                        ForEach(ChatHistoryVm.chat, id:\.id){ chat in
                            NavigationLink(destination: ChatScreen(chatScreenVm: ChatScreenViewModel(chat: chat))){
                                CustomChatHistoryView(title: chat.title, last_message: chat.lastMessage, data: ChatHistoryVm.getDate(chat.created), time: ChatHistoryVm.getTime(chat.created)).padding(.bottom, 2)
                            }
                        }.refreshable {
                            ChatHistoryVm.showChatHistory(questions: botQuery, settings: settings)
                        }
                    }
                }
                Spacer()
            }.navigationBarTitle("Chats")
                .navigationBarItems(trailing: Button(action: {
                    ChatHistoryVm.logOut(settings: settings)
                }, label:{ Image(systemName:"rectangle.portrait.and.arrow.right" ).frame(width: 40, height: 40)}))
//                .onAppear{
//                    ChatHistoryVm.showChatHistory(questions: botQuery, settings: settings)
//                }
            VStack {
                Spacer()
                HStack {
                    Spacer()
    //                    NavigationLink(destination: chatBotPage(), isActive:$showChatPage){
                    NavigationLink(destination: ChatBot(), isActive: $ChatHistoryVm.showNewBotView){
                        Button(action: {
                            //                            showChatPage = true
                            ChatHistoryVm.showNewBotView = true
                        }, label: {
                            Image(systemName: "plus.circle.fill").resizable().scaledToFill().frame(width: 60,height: 60).padding()
                        })
                        //                    }
                    }
                }
            }
        }.onAppear{
            ChatHistoryVm.setUpApp(questions: botQuery, settings: settings)
        }
    }
}

struct ChatHistory_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatHistory()
                .environmentObject(UserSettings())
        }
    }
}

//        VStack{

//}.navigationBarTitle("Chats")
//    .navigationBarItems(trailing: Button(action: {
//        settings.settingUser(user: User(username: "", firstname: "", lastname: "", secret: ""))
//    }, label:{ Image(systemName:"rectangle.portrait.and.arrow.right" )}))

