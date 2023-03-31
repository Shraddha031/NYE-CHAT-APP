//
//  SignUpViewModel.swift
//  ChatApp2.0
//
//  Created by Shraddha on 26/03/23.
//

import Foundation

enum FocusStates {
    case username
    case password
    case firstName
    case lastName
}

class SignUpViewModel: ObservableObject {
    
    //username
    @Published var usernameTf: String = ""
    @Published var usernameShowError: Bool = false
    //firstname
    @Published var firstnameTf: String = ""
    @Published var firstnameShowError: Bool = false
    //lastname
    @Published var lastnameTf: String = ""
    @Published var lastnameShowError: Bool = false
    //password
    @Published var passwordTf: String = ""
    @Published var passwordError: Bool = false
    
    //
    @Published var loginSuccessfull = false
    //
    @Published var showSingupErrorAlert = false
    @Published var textSingupErrorAlert = "Username already taken"
    @Published var showLoading = false

    func registerUser(username: String, firstname: String, lastname: String, secret: String) -> RegisterModel{
        RegisterModel(username: username, first_name: firstname, last_name: lastname, secret: secret)
    }
    func isNameValid(input: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", "\\w{2,26}")
        return test.evaluate(with: input)
    }
    
    func isUsernameValid(input: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", "\\w{7,18}")
        return test.evaluate(with: input)
    }
    
    func isPasswordValid(input: String) -> Bool {
        let pswdRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let pswdPred = NSPredicate(format:"SELF MATCHES %@", pswdRegEx)
        return pswdPred.evaluate(with: input)
    }
    func signUp() -> FocusStates?{
        if isUsernameValid(input: usernameTf){
            if isNameValid(input: firstnameTf){
                if isNameValid(input: lastnameTf){
                    if isPasswordValid(input: passwordTf){
                        showLoading = true
                        NetworkManager.shared.requestForApi(urlString: "https://api.chatengine.io/users/", registerUser(username: usernameTf, firstname: firstnameTf, lastname: lastnameTf, secret: passwordTf), method: "POST", completionHandler: {
                            data in
                            guard let data = data as? [String: Any] else {return}
                            if let data = data["first_name"] as? String {
                                self.loginSuccessfull = true
                            }else{
                                self.textSingupErrorAlert = "Username already taken"
                                self.loginSuccessfull = true
                            }
                            
                            print(data)
                        },errorHandler: { err in
                            self.textSingupErrorAlert = "Can't reach server at the moment"
                            self.showSingupErrorAlert = true
                            self.showLoading = false
                        })
                        return nil
                    }else{
                        passwordError = true
                        return .password
                    }
                    
                }else{
                    lastnameShowError = true
                    return .lastName
                }
                
            }else{
                firstnameShowError = true
                return .firstName
            }
            
        }else{
            usernameShowError = true
            return .username
        }
    }
    
    func UsernameCheck() {
        usernameShowError = !isUsernameValid(input: usernameTf)
    }
    func FirstNameCheck() {
        firstnameShowError = !isNameValid(input: firstnameTf)
    }
    func LastNameCheck() {
        lastnameShowError = !isNameValid(input: lastnameTf)
    }
    func SecretCheck() {
        passwordError = !isPasswordValid(input: passwordTf)
    }

}
