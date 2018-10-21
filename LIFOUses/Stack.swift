//
//  Stack.swift
//  LIFOUses
//
//  Created by Tim Beals on 2018-10-20.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import Foundation

class Node<T: CustomStringConvertible> : CustomStringConvertible {
    
    var value: T
    weak var previous: Node<T>?
    var next: Node<T>?
    
    init(value: T) {
        self.value = value
    }
    
    var description: String {
        return value.description
    }
}


class Stack<T: CustomStringConvertible> {
    
    var rootNode: Node<T>?
    var endNode: Node<T>?
    
    init() {}
    init(values: T...) {
        for val in values {
            push(value: val)
        }
    }
    
    func push(value: T) {
        let newNode = Node<T>(value: value)
        if let end = endNode {
            end.next = newNode
            newNode.previous = end
        } else {
            rootNode = newNode
        }
        endNode = newNode
    }
    
    func pop() -> T? {
        let val = endNode?.value
        if endNode === rootNode {
            rootNode = nil
        }
        endNode = endNode?.previous
        endNode?.next = nil
        return val
    }
    
    func isEmpty() -> Bool {
        return rootNode == nil
    }
    
    func printStack() {
        var currentNode = rootNode
        while currentNode != nil {
            print(currentNode!.value)
            currentNode = currentNode?.next
        }
    }
}
