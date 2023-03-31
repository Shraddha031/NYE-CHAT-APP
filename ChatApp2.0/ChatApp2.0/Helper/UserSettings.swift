//
//  UserSettings.swift
//  ChatApp2.0
//
//  Created by Shraddha on 26/03/23.
//

import Foundation
class UserSettings: ObservableObject{
    @Published var user: User
    
    init(){
        self.user = User(username: UserDefaults.standard.value(forKey: "username") as? String ?? "USERNAME", firstname: UserDefaults.standard.value(forKey: "firstname") as? String ?? "FIRSTNAME", lastname: UserDefaults.standard.value(forKey: "lastname") as? String ?? "LASTNAME", secret: UserDefaults.standard.value(forKey: "secret") as? String ?? "SECRET")
    }
    func settingUser(user: User){
        self.user = user
    }
    
}
