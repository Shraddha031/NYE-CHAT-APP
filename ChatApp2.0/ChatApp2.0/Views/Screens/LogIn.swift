//
//  LogIn.swift
//  ChatApp2.0
//
//  Created by Shraddha on 26/03/23.
//

import SwiftUI

struct LogIn: View {
    @StateObject private var LogInVm = LogInViewModel()
    @FocusState private var focusedTF: FocusStatesLogin?
    //
    @State private var isActive = false
    @EnvironmentObject private var settings: UserSettings
    var body: some View {
            VStack{
                Image("Logo").resizable().scaledToFill().frame(width: 70,height: 70).padding(.bottom)
                Text("Welcome to Chat App")
                    .font(.title)
                    .fontWeight(.bold).padding(.bottom,2)
                Text("Please fill the your login details")
                    .font(.system(size: 13))
                    .fontWeight(.bold).foregroundColor(.gray).padding(.bottom, 50)
                CustomTextField(title:"Username", text: $LogInVm.usernameTf, showError: $LogInVm.usernameShowError).padding(.bottom, 5).focused($focusedTF, equals: .username).onSubmit {
                    LogInVm.UsernameCheck()
                    focusedTF = .secret
                }
                CustomPasswordTextField(title:"Password", text: $LogInVm.passwordTf, showError: $LogInVm.passwordError).padding(.bottom, 30).focused($focusedTF, equals: .secret).onSubmit {
                    LogInVm.SecretCheck()
                }
                CustomButton(btnTitle: LogInVm.showLoading ? "Loading..." : "Log In"){
                    focusedTF = nil
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.001){
                        focusedTF = LogInVm.LogIn(settings: self.settings)
                        
                    }
                   
                }.padding(.bottom, 5)
                    .alert(LogInVm.textLoginAlert, isPresented: $LogInVm.showAlert){
                }
                HStack{
                    Text("Don't have an account?")
                    NavigationLink(destination: SignUp(), isActive: $isActive){
                        Button(action: {
                            isActive = true
                        }, label: {Text("Sign Up")}).foregroundColor(Color("Primary"))
                    }
                }
            }.padding().padding(.horizontal, 6)
    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}
