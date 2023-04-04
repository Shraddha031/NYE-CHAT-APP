//
//  CustomButtonView.swift
//  ChatApp2.0
//
//  Created by Shraddha on 30/03/23.
//

import SwiftUI


//file for design of custom button so that it can be easily be accessed at any other place
struct CustomButtonView: View {
    var btnTitle: String?
    var action: (() -> Void)?
    var pressed: Bool?
    var body: some View {
        
            HStack{
                Button(action: action ??  {
                    print("No Action")
                },label : {
                    Text(btnTitle ?? "Button")
                        .fontWeight(.semibold).foregroundColor(pressed! ? .white : .black)
                }).padding().background(pressed! ? Color("Primary") : .white)
                    .background(.white)
                    .cornerRadius(5)
                    
            }
        }
    
}

struct CustomButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonView()
    }
}
