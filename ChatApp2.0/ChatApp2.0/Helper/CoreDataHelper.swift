//
//  CoreDataHelper.swift
//  ChatApp2.0
//
//  Created by Shraddha on 28/03/23.
//

import Foundation


class CoreDataHelper{
    
    static func saveExistingQuestions(){
        let firstLevelQuestions = [ChatBotModel(id: UUID(), botQue: "NYE Prepaid Card"),
                                   ChatBotModel(id: UUID(), botQue: "Open Account"),
                                   ChatBotModel(id: UUID(), botQue: "Rapi Money"),
                                   ChatBotModel(id: UUID(), botQue: "UPI Payments")]
        //if user select NYE Prepaid Card
        let secondLevelQuestions = [ChatBotModel(id: UUID(),parentId: firstLevelQuestions[0].id, botQue: "Check Balance"),
                                    ChatBotModel(id: UUID(),parentId: firstLevelQuestions[0].id, botQue: "Change PIN"),
                                    ChatBotModel(id: UUID(),parentId: firstLevelQuestions[0].id, botQue: "Block Card"),
                                    ChatBotModel(id: UUID(),parentId: firstLevelQuestions[0].id, botQue: "Issue a new Card"),
                                    
        //if user select NYE Open Account
                                    ChatBotModel(id: UUID(),parentId: firstLevelQuestions[1].id, botQue: "Salary Account"),
                                    ChatBotModel(id: UUID(),parentId: firstLevelQuestions[1].id, botQue: "Fixed Deposit"),
                                    ChatBotModel(id: UUID(),parentId: firstLevelQuestions[1].id, botQue: "Recurring Deposit"),
                                    ChatBotModel(id: UUID(),parentId: firstLevelQuestions[1].id, botQue: "Joint Account"),
                                    
        //if user select Rapi Money
                                    ChatBotModel(id: UUID(),parentId: firstLevelQuestions[2].id, botQue: "Pick from the wide options of mutual funds"),
                                    ChatBotModel(id: UUID(),parentId: firstLevelQuestions[2].id, botQue: "Get maximum profit by investing into suggested mutual funds"),
                                    
        //if user select UPI Payments
                                    ChatBotModel(id: UUID(),parentId: firstLevelQuestions[3].id, botQue: "Add Bank Account"),
                                    ChatBotModel(id: UUID(),parentId: firstLevelQuestions[3].id, botQue: "Change UPI pin"),
                                    ChatBotModel(id: UUID(),parentId: firstLevelQuestions[3].id, botQue: "Link your number with UPI ID")]
        //if user select NYE Prepaid Card--Check Balance"
        let thirdLevelQuestions = [ChatBotModel(id: UUID(),parentId: secondLevelQuestions[0].id, botQue: "Login to NYE Banking App"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[0].id, botQue: "Go to My Cards"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[0].id, botQue: "Click on view balance to check your balance"),
          
        //if user select NYE PREPAID CARD - CHANGE PIN"
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[1].id, botQue: "Login to NYE Banking App"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[1].id, botQue: "Go to My Cards"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[1].id, botQue: "Click on change pin"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[1].id, botQue: "Enter new PIN"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[1].id, botQue: "Enter the OTP for completing the process."),
        //if user select  NYE PREPAID CARD - BLOCK CARD
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[2].id, botQue: "Login to NYE Banking App"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[2].id, botQue: "Go to My Cards"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[2].id, botQue: "Click on block card and enter the reason"),
        //if user select  NYE PREPAID CARD - ISSUE A NEW CARD
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[3].id, botQue: "Login to NYE Banking App"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[3].id, botQue: "Go to My Cards"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[3].id, botQue: "Click on request new card"),
        //if user select   OPEN ACCOUNT - SALARY ACCOUNT
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[4].id, botQue: "Login to NYE Banking App"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[4].id, botQue: "Go to My Accounts"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[4].id, botQue: "Apply for Salary Account"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[4].id, botQue: "You will get a ticket for your request"),
        //if user select   OPEN ACCOUNT - FIXED DEPOSIT
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[5].id, botQue: "Login to NYE Banking App"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[5].id, botQue: "Go to My Accounts"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[5].id, botQue: "Apply for Salary Account"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[5].id, botQue: "You will get a ticket for your request"),
     //if user select    OPEN ACCOUNT - RECURRING DEPOSIT
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[6].id, botQue: "Login to NYE Banking App"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[6].id, botQue: "Go to My Accounts"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[6].id, botQue: "Click on My Deposits"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[6].id, botQue: "Click on create a recurring deposit"),
    //if user select    OPEN ACCOUNT -- JOINT ACCOUNT
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[7].id, botQue: "Login to NYE Banking App"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[7].id, botQue: "Select apply for new Account"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[7].id, botQue: "Select Joint Account from the options and follow the steps"),
        //if user select     UPI - ADD BANK ACCOUNT
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[10].id, botQue: "Login to NYE Banking App"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[10].id, botQue: "Go to UPI"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[10].id, botQue: "Select Add Bank Account"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[10].id, botQue: "You will recieve a message on success"),
        //if user select UPI - CHANGE UPI PIN
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[11].id, botQue: "Login to NYE Banking App"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[11].id, botQue: "Go to UPI"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[11].id, botQue: "Click on change UPI"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[11].id, botQue: "Enter the new PIN"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[11].id, botQue: "Enter the OTP for completing the process"),
        //if user selects UPI - LINK YOUR NUMBER WITH UPI ID
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[12].id, botQue: "Login to NYE Banking App"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[12].id, botQue: "Go to UPI"),
                                   ChatBotModel(id: UUID(),parentId: secondLevelQuestions[12].id, botQue: "Click on link number")]
        
        for botque in firstLevelQuestions{
            PersistenceController.shared.saveQuestionData(botQue: botque.botQue, id: botque.id, parentId: botque.parentId)
        }
        for botque in secondLevelQuestions{
            PersistenceController.shared.saveQuestionData(botQue: botque.botQue, id: botque.id, parentId: botque.parentId)
        }
        for botque in thirdLevelQuestions{
            PersistenceController.shared.saveQuestionData(botQue: botque.botQue, id: botque.id, parentId: botque.parentId)
        }
    }
}
