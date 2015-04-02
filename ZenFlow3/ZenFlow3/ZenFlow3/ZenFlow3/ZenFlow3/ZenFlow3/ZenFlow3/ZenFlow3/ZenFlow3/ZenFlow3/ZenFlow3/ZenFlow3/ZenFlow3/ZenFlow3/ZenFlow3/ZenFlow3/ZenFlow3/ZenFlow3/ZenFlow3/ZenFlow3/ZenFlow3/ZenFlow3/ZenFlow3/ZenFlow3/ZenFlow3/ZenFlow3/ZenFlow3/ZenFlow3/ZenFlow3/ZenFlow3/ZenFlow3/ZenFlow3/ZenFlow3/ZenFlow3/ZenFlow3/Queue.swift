//
//  Queue.swift
//  ZenFlow3
//
//  Created by Alexander Goddijn on 14/03/2015.
//  Copyright (c) 2015 Alexander Goddijn. All rights reserved.
//

import Foundation

class QNode<T> {
    var value: T
    var next: QNode?
    
    init(item:T) {
        value = item
    }
}


struct Queue<T> {
    private var top: QNode<T>!
    private var bottom: QNode<T>!
    var length: Int
    
    init() {
        top = nil
        bottom = nil
        length = 0
    }
    
    mutating func enQueue(item: T) {
        
        length++
        
        var newNode:QNode<T> = QNode(item: item)
        
        if top == nil {
            top = newNode
            bottom = top
            return
        }
        
        bottom.next = newNode
        bottom = newNode
    }
    
    mutating func deQueue() -> T? {
        
        let topItem: T? = top?.value
        if topItem == nil {
            return nil
        }
        
        if let nextItem = top.next {
            top = nextItem
        } else {
            top = nil
            bottom = nil
        }
        
        length--
        return topItem
    }
    
    func isEmpty() -> Bool {
        
        return top == nil ? true : false
    }
    
    func peek() -> T? {
        return top?.value
    }
    
}