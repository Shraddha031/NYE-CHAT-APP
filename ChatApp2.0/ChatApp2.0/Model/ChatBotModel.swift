//
//  ChatBotModel.swift
//  ChatApp2.0
//
//  Created by Shraddha on 28/03/23.
//

import Foundation

struct ChatBotModel: Identifiable{
    var id: UUID
    var parentId: UUID?
    var botQue: String
    var pressed: Bool
    init(id: UUID, parentId: UUID? = nil, botQue: String, pressed: Bool = true) {
        self.id = id
        self.parentId = parentId
        self.botQue = botQue
        self.pressed = pressed
    }
}
