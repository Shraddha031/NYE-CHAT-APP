//
//  ChatModel.swift
//  ChatApp2.0
//
//  Created by Shraddha on 27/03/23.
//

import Foundation

struct ChatModel: Identifiable{
    var id: Int
    var sender: String
    var receiver: String
    var title: String
    var accessKey: String
    var lastMessage:String
    var created: String
}
