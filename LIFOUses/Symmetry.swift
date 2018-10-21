//
//  Symmetry.swift
//  LIFOUses
//
//  Created by Tim Beals on 2018-10-21.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import Foundation

//MARK: Testing Symmetry
extension String {
    
    func balancedBrackets() -> Bool {
        
        guard self.count % 2 == 0 else { return false }
        let disallowedCharacters = NSCharacterSet(charactersIn: "(){}[]<>").inverted
        guard self.rangeOfCharacter(from: disallowedCharacters) == nil else { return false }
        
        var bracketPairs: [Character: Character] = ["[": "]", "<": ">", "{": "}", "(":")"]
        let stack = Stack<Character>()
        var firstHalf = true
        
        for char in self {
            if bracketPairs.keys.contains(char) {
                if !firstHalf { return false }
                stack.push(value: char)
            } else {
                firstHalf = false
                guard !stack.isEmpty() else { return false }
                let openBracket = stack.pop()!
                let expectedChar = bracketPairs[openBracket]
                if expectedChar != char {
                    return false
                }
            }
        }
        return true
    }
}



