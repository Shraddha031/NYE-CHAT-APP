//
//  CustomButton.swift
//  ChatApp2.0
//
//  Created by Shraddha on 26/03/23.
//

import SwiftUI
struct CustomButton: View {
    var btnTitle: String?
    var action: (() -> Void)?
    var body: some View {
        Button(action: action ??  {
            print("No Action")
        },label : {
            Spacer()
            Text(btnTitle ?? "Button")
                .font(.title3)
                .fontWeight(.semibold)
            Spacer()
        }).padding().frame(maxWidth: .infinity)
        .background(Color("Primary"))
            .cornerRadius(5)
            .foregroundColor(.white)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton()
    }
}

//
