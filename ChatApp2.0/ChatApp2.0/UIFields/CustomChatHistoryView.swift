//
//  CustomChatHistoryView.swift
//  ChatApp2.0
//
//  Created by Shraddha on 27/03/23.
//

import SwiftUI

struct CustomChatHistoryView: View {
    var title: String
    var last_message: String
    var data: String
    var time: String
    var body: some View {
        HStack{
            Image(systemName: chatHistoryImages.images[title] ?? "person.fill").font(.largeTitle).frame(width: 60, height: 60).background(Color("Secondary")).cornerRadius(50).foregroundColor(Color("Primary"))
                VStack(alignment: .leading){
                    Text(title).font(.system(size: 20)).fontWeight(.bold).foregroundColor(.black).padding(.top)
                    Text(last_message).fontWeight(.semibold).font(.system(size: 14)).padding(.bottom, 0.3).foregroundColor(.gray)
                    HStack{
                        Text(data)
                        Text(time)
                    }.foregroundColor(.gray).fontWeight(.medium).font(.system(size: 10)).padding(.bottom)
                }
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(systemName: "chevron.forward").font(.title2).fontWeight(.semibold)
                }).padding(.leading, 30)
        }.padding().frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.12).background(.white).cornerRadius(15)
    }
}

struct CustomChatHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        CustomChatHistoryView(title: "Change UPI Pin", last_message: "For further process contact us ", data: "17-01-2000", time: "11:30")
    }
}
