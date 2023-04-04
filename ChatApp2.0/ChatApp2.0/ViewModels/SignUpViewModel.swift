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
    //this functionc checks that name should be of length between 2 to 26 
    func isNameValid(input: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", "\\w{2,26}")
        return test.evaluate(with: input)
    }
    //this functionc checks that username should be of length between 7 to 18 and only contains small and capital letters and underscore
    func isUsernameValid(input: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", "\\w{7,18}")
        return test.evaluate(with: input)
    }
    //this functions checks that password entered should contain atleast of special character, number, capital letter, lower case character and shoul be greater that length 8
    func isPasswordValid(input: String) -> Bool {
        let pswdRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let pswdPred = NSPredicate(format:"SELF MATCHES %@", pswdRegEx)
        return pswdPred.evaluate(with: input)
    }
    //this function register a new user by posting them to api if all the fields got validated
    //it returns focus state enum which is required for focusing the textfield that has invalid data

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
    //this function checks that username entered if valid or not
    func UsernameCheck() {
        usernameShowError = !isUsernameValid(input: usernameTf)
    }
    //this function checks that FirstName entered if valid or not
    func FirstNameCheck() {
        firstnameShowError = !isNameValid(input: firstnameTf)
    }
    //this function checks that LastNameCheck entered if valid or not
    func LastNameCheck() {
        lastnameShowError = !isNameValid(input: lastnameTf)
    }
    //this function checks that password entered if valid or not
    func SecretCheck() {
        passwordError = !isPasswordValid(input: passwordTf)
    }

}
