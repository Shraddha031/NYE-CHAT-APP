//
//  Persistence.swift
//  ChatApp2.0
//
//  Created by Shraddha on 26/03/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    init(){
        container = NSPersistentContainer(name: "ChatApp2_0")
        context = container.viewContext
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    func save(){
        do {
            try context.save()
        } catch {
            print("Save Error")
        }
    }
    func saveQuestionData(botQue: String, id: UUID, parentId: UUID?){
        let botQuestions = BotQuestions(context: self.context)
        botQuestions.id = id
        botQuestions.parentId = parentId
        botQuestions.botQue = botQue
        botQuestions.created = Date()
        save()
    }
}
