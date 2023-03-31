//
//  ContentView.swift
//  ChatApp2.0
//
//  Created by Shraddha on 26/03/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject private var settings: UserSettings
    @Environment(\.managedObjectContext) var managedObjectContext
    var body: some View {
        NavigationView{
            if settings.user.secret == ""{
                LogIn()
            }
            else{
                ChatHistory()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserSettings())
    }
}
