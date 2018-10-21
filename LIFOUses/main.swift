//
//  main.swift
//  LIFOUses
//
//  Created by Tim Beals on 2018-10-20.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import Foundation

//MARK: Basic Functionality
var stack = Stack<Int>(values: 1, 2, 3, 4, 5)

stack.printStack() //1, 2, 3, 4, 5
_ = stack.pop()
stack.push(value: 6)
stack.printStack() //1, 2, 3, 4, 6


//MARK: Reverse a list
var stackA = Stack<String>(values: "A", "B", "C")
stackA.printStack() //ABC

var stackB = Stack<String>()

while !stackA.isEmpty() {
    let val = stackA.pop()!
    stackB.push(value: val)
}
stackB.printStack() //CBA

//MARK: Testing Symmetry
print("[(<{}>)]".balancedBrackets()) //true
print("[(<>){}]".balancedBrackets()) //false


//MARK: Undo History with Command Pattern
let bankAccount = BankAccount()
bankAccount.process(command: BankAccountCommand(action: .deposit, amount: 300))
bankAccount.process(command: BankAccountCommand(action: .deposit, amount: 200))
print(bankAccount) //Account with balance: 500 and overdraft: -500
_ = bankAccount.undoLastCommand()
print(bankAccount) //Account with balance: 300 and overdraft: -500
