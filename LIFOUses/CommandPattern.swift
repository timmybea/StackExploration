//
//  CommandPattern.swift
//  LIFOUses
//
//  Created by Tim Beals on 2018-10-21.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import Foundation

//class BankAccount : CustomStringConvertible {
//    
//    private var balance = 0
//    private let overdraftLimit = -500
//    
//    func deposit(_ amt: Int) {
//        balance += amt
//    }
//    
//    func withdraw(_ amt: Int) -> Bool {
//        if (balance - amt >= overdraftLimit) {
//            balance -= amt
//            return true
//        }
//        return false
//    }
//    
//    var description: String {
//        return "Account with balance: \(balance) and overdraft: \(overdraftLimit)"
//    }
//}



class BankAccount : CustomStringConvertible {
    
    private var commandStack = Stack<BankAccountCommand>()
    private var balance = 0
    private let overdraftLimit = -500
    
    func process(command: BankAccountCommand) {
        command.call(with: self)
        commandStack.push(value: command)
    }
    
    func undoLastCommand() -> BankAccountCommand? {
        let command = commandStack.pop()
        command?.undo(with: self)
        return command
    }
    
    fileprivate func deposit(_ amt: Int) {
        balance += amt
    }
    
    fileprivate func withdraw(_ amt: Int) -> Bool {
        if (balance - amt >= overdraftLimit) {
            balance -= amt
            return true
        }
        return false
    }
    
    var description: String {
        return "Account with balance: \(balance) and overdraft: \(overdraftLimit)"
    }
}

class BankAccountCommand : CustomStringConvertible {
    
    enum Action {
        case deposit
        case withdraw
    }
    
    private var action: Action
    private var amount: Int
    private var succeeded: Bool = false
    
    init(action: Action, amount: Int) {
        self.action = action
        self.amount = amount
    }
    
    func call(with account: BankAccount) {
        switch action {
        case .deposit:
            account.deposit(amount)
            succeeded = true
        case .withdraw:
            succeeded = account.withdraw(amount)
        }
    }
    
    func undo(with account: BankAccount) {
        if !succeeded { return }
        
        switch action {
        case .deposit:
            _ = account.withdraw(amount)
        case .withdraw:
            account.deposit(amount)
        }
    }
    
    var description: String {
        return "Command \(action) amount \(amount)"
    }
}
