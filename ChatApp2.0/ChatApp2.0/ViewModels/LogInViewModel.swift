//
//  LogInViewModel.swift
//  ChatApp2.0
//
//  Created by Shraddha on 27/03/23.
//

import Foundation
enum FocusStatesLogin{
    case username
    case secret
}
class LogInViewModel: ObservableObject{
    //username
    @Published var usernameTf: String = ""
    @Published var usernameShowError: Bool = false
    //password
    @Published var passwordTf: String = ""
    @Published var passwordError: Bool = false
    //
    @Published var showAlert = false
    //
    @Published var textLoginAlert = "Invalid Credentials"
    @Published var showLoading = false
    
    func isUsernameValid(input: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", "\\w{7,18}")
        return test.evaluate(with: input)
    }
    
    func isPasswordValid(input: String) -> Bool {
        let pswdRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let pswdPred = NSPredicate(format:"SELF MATCHES %@", pswdRegEx)
        return pswdPred.evaluate(with: input)
    }
    func UsernameCheck() {
        usernameShowError = !isUsernameValid(input: usernameTf)
    }
    func SecretCheck() {
        passwordError = !isPasswordValid(input: passwordTf)
    }
    func setData(_ register: User, settigns: UserSettings){
        UserDefaults.standard.set(register.username, forKey: "username")
        UserDefaults.standard.set(register.firstname, forKey: "firstname")
        UserDefaults.standard.set(register.lastname, forKey: "lastname")
        UserDefaults.standard.set(register.secret, forKey: "secret")
        settigns.settingUser(user: register)
    }
    func LogIn(settings: UserSettings) -> FocusStatesLogin? {
        if isUsernameValid(input: usernameTf){
            if isPasswordValid(input: passwordTf){
                showLoading = true
                NetworkManager.shared.getChatApi(urlString: "https://api.chatengine.io/users/me/", requestFor: "login", 111, method: "GET", username: usernameTf, userScret: passwordTf, requestInfo: nil, completionHandler: {
                    data in
                    guard let data = data as? [String: Any] else {return}
                    print(data)
                    if let suc = data["first_name"] as? String{
                        print(data["first_name"])
                        self.setData(User(username: self.usernameTf, firstname: data["first_name"] as! String, lastname: data["last_name"] as! String, secret: self.passwordTf), settigns: settings)
                    }else{
                        self.textLoginAlert = "Invalid Credentials"
                        self.showAlert = true
                    }
                    self.showLoading = false
                },errorHandler: { err in
                    self.textLoginAlert = "Can't reach server at the moment"
                    self.showAlert = true
                    self.showLoading = false
                })
                return nil
            }else{
                passwordError = true
                return .secret
            }
            
        }else{
            usernameShowError = true
            return .username
        }
    }
}





