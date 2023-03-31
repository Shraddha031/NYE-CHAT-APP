//
//  SignUp.swift
//  ChatApp2.0
//
//  Created by Shraddha on 26/03/23.
//

import SwiftUI

struct SignUp: View {
    @StateObject private var SignUpVm = SignUpViewModel()
    //
    @FocusState var focusedTF: FocusStates?
    @Environment(\.presentationMode) var presentation
    @State private var isActive = false
    var body: some View {
        VStack{
            Image("Logo").resizable().scaledToFill().frame(width: 70,height: 70).padding(.bottom)
            Text("Welcome to Chat App")
                .font(.title)
                .fontWeight(.bold).padding(.bottom,2)
            Text("Please fill the details and create account")
                .font(.system(size: 13))
                .fontWeight(.bold).foregroundColor(.gray).padding(.bottom, 50)
            CustomTextField(title:"Username", text: $SignUpVm.usernameTf, showError: $SignUpVm.usernameShowError).padding(.bottom, 5).focused($focusedTF, equals: .username)
                .onSubmit {
                SignUpVm.UsernameCheck()
                focusedTF = .username
            }
            CustomTextField(title:"Firstname", text: $SignUpVm.firstnameTf, showError: $SignUpVm.firstnameShowError).padding(.bottom,5).focused($focusedTF, equals: .firstName)
                .onSubmit {
                SignUpVm.FirstNameCheck()
                focusedTF = .firstName
            }
            CustomTextField(title:"Lastname", text: $SignUpVm.lastnameTf, showError: $SignUpVm.lastnameShowError).padding(.bottom,5).focused($focusedTF, equals: .lastName).onSubmit {
                SignUpVm.LastNameCheck()
                focusedTF = .lastName
            }
            CustomPasswordTextField(title:"Password", text: $SignUpVm.passwordTf, showError: $SignUpVm.passwordError).padding(.bottom, 30).focused($focusedTF, equals: .password).onSubmit {
                SignUpVm.SecretCheck()
                focusedTF = .password
            }
            CustomButton(btnTitle: SignUpVm.showLoading ? "Loading..." : "Sign Up"){
                focusedTF = nil
                DispatchQueue.main.asyncAfter(deadline: .now()+0.001){
                    focusedTF = SignUpVm.signUp()
                }
            }.padding(.bottom, 5)
            HStack{
                Text("Already have an account?")
                NavigationLink(destination: LogIn(), isActive: $isActive){
                    Button(action: {
                        isActive = true
                    }, label: {Text("Log In")}).foregroundColor(Color("Primary"))
                }
            }
        }.padding().padding(.horizontal, 6).alert("Sign Up Sucessfully", isPresented: $SignUpVm.loginSuccessfull){
            Button("GO TO SIGN IN"){
                self.presentation.wrappedValue.dismiss()
            }
        }.alert(SignUpVm.textSingupErrorAlert, isPresented: $SignUpVm.showSingupErrorAlert){}
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
