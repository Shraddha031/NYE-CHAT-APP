//
//  CustomMessageText.swift
//  ChatApp2.0
//
//  Created by Shraddha on 27/03/23.
//

import SwiftUI
struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

struct CustomMessageText: View {
    var sender: Bool
    var message: String
    var created: String
    var body: some View {
        VStack(alignment: .trailing){
            Text(message).foregroundColor(sender ? .white : .black).fontWeight(.semibold).padding(.top)
            Text(created).font(.caption2).foregroundColor(sender ? .white.opacity(0.8) : .gray ).fontWeight(.semibold).padding(.top, 0.5).padding(.bottom, 2)
        }.padding(.horizontal).background(sender ? Color("Primary") : .white).cornerRadius(20, corners: sender ? [.bottomLeft, .bottomRight,.topLeft] : [.bottomLeft, .bottomRight,.topRight])
        
    }
    
}
struct customBotMessage: View{
    var body: some View{
        VStack(alignment: .trailing){
            Text("Hi I am NYE chatbot your personal digital assistance").padding(.bottom).foregroundColor(.black).fontWeight(.semibold).padding(.top)
        }.padding(.horizontal).background(.white).cornerRadius(20, corners:  [.bottomLeft, .bottomRight,.topRight])
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}

struct CustomMessageText_Previews: PreviewProvider {
    static var previews: some View {
        CustomMessageText(sender: false, message: "Hey There Siuu", created: "09:45")
    }
}
struct CustomBotMessage_Previews: PreviewProvider {
    static var previews: some View{
        customBotMessage()
    }
}

