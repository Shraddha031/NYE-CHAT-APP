//
//  CustomTextField.swift
//  ChatApp2.0
//
//  Created by Shraddha on 26/03/23.
//

import SwiftUI

struct CustomTextField: View {
    var title: String = ""
    @Binding var text: String
    @Binding var showError: Bool
    @State private var borderColor = Color.gray
    @FocusState private var showLabel
    var body: some View {
        ZStack{
            TextField(title, text: $text).onChange(of: text, perform: {
                data in
                showError = false
                borderColor = showError ? Color(.red) : Color("Primary")
            }).focused($showLabel).textInputAutocapitalization(.never).autocorrectionDisabled().padding().font(.system(size: 17))
                .overlay {
                RoundedRectangle(cornerRadius: 5, style: .continuous).stroke( borderColor,lineWidth: 1.5).shadow(color: .gray, radius: 10)
            }
            if showLabel {
                HStack {
                    Text(title)
                        .fontWeight(.semibold)
                        .foregroundColor(borderColor)
                        .padding(.horizontal, 5)
                        .background(Color.white)
                    Spacer()
                }
                .padding(.bottom, 50)
                .padding(.leading, 15)
                .onAppear() {
                        borderColor = showError ? Color.red : Color("Primary")
                }
                .onDisappear() {
                        borderColor = showError ? Color.red : Color.gray
                }
            }
        }
    }
}

struct UIFields_Previews: PreviewProvider {
    static var previews: some View {
       CustomTextField(title: "Title", text: .constant(""), showError: .constant(false))
    }
}
