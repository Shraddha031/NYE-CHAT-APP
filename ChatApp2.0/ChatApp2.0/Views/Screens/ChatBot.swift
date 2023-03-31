//
//  ChatBot.swift
//  ChatApp2.0
//
//  Created by Shraddha on 28/03/23.
//

import SwiftUI

struct ChatBot: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.created)]) var botQuery: FetchedResults<BotQuestions>
    @EnvironmentObject private var settings: UserSettings
    @StateObject private var ChatBotVm = ChatBotViewModel()
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Secondary"), Color("Secondary")]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            VStack{
                ScrollView{
                    HStack{
                        customBotMessage()
                        Spacer()
                    }
                    ScrollViewReader{ value in
                        ForEach(ChatBotVm.botQuestions, id: \.id) { botQue in
                            HStack{
                                if !botQue.pressed{
                                    Spacer()
                                }
//                                HStack{
//                                    Button(action: {
//                                        ChatBotVm.continueProcess(question: botQue)
//                                    }, label: {
//                                        Text(botQue.botQue)
//                                    })
//                                }
                                CustomButtonView(btnTitle: botQue.botQue,action: {
                                    ChatBotVm.continueProcess(question: botQue)
                                }, pressed: !botQue.pressed).onAppear(){
                                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                                        value.scrollTo(ChatBotVm.botQuestions[ChatBotVm.botQuestions.count - 1].id)
                                    }
                                }
                                if botQue.pressed{
                                    Spacer()
                                }
                            }
                        }
                        HStack{
                            NavigationLink(destination: ChatScreen(chatScreenVm: ChatScreenViewModel(chat: ChatBotVm.chat ?? ChatBotVm.temp)), isActive: $ChatBotVm.showChatScreen){
                                CustomButton(btnTitle: "Contact Executive"){
                                    ChatBotVm.createChatRoom(settings: self.settings)
                                }.padding(.trailing, 47)
                                Spacer()
                            }
                        }
                    }
                }
            }.padding(.horizontal).onAppear(){
                print(botQuery.count)
                ChatBotVm.showBotQuestions(allQuestions: self.botQuery)
        }
        }
    }
}

struct ChatBot_Previews: PreviewProvider {
    static var previews: some View {
        ChatBot().environmentObject(UserSettings())
    }
}

