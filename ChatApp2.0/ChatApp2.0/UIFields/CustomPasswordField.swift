//
//  CustomPasswordField.swift
//  ChatApp2.0
//
//  Created by Shraddha on 26/03/23.
//

import SwiftUI

struct CustomPasswordTextField: View {
    var title: String = ""
    @Binding var text: String
    @Binding var showError: Bool
    @State private var borderColor = Color.gray
    @FocusState private var showLabel
    var body: some View {
        ZStack{
            SecureField(title, text: $text).onChange(of: text, perform: { data in
                showError = false
                borderColor = showError ? Color.red : Color("Primary")
            }).focused($showLabel).textInputAutocapitalization(.never).autocorrectionDisabled().font(.system(size: 17))
               .padding()
                .overlay {
                RoundedRectangle(cornerRadius: 5, style: .continuous).stroke( .gray,lineWidth: 1.5).shadow(color: .gray, radius: 10)
            }
            if showLabel {
                HStack {
                    Text(title)
                        .fontWeight(.semibold)
                        .foregroundColor(showError ? Color.red : Color("Primary"))
                        .padding(.horizontal, 5)
                        .background(Color.white)
                    Spacer()
                }.padding(.bottom, 50)
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

struct CustomPasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomPasswordTextField(title: "Title", text: .constant(""), showError: .constant(false))
    }
}
