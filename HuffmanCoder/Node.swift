//
//  Node.swift
//  HuffmanCoder
//
//  Created by Raven O'Rourke on 8/12/21.
//

import Foundation

class Node {
    var freq: Int = 0
    var char: Character? = nil
    var left_child: Node? = nil
    var right_child: Node? = nil
    var is_leaf: Bool {
        guard left_child == nil else {
            print("test: node with freq \(freq) has left child")
            return false
        }
        guard right_child == nil else {
            print("test: node with freq \(freq) has right child")
            return false
        }
        print("test: node with freq \(freq) is leaf")
        return true
    }
    
    init(freq: Int = 0, char: Character? = nil, left_child: Node? = nil, right_child: Node? = nil) {
        self.char = char
        self.freq = freq
        self.left_child = left_child
        self.right_child = right_child
    }
    
    static func compare_nodes_maxheap(a: Node , b: Node) -> Bool {
        return a.freq > b.freq
    }
    
    static func compare_nodes_minheap(a: Node , b: Node) -> Bool {
        return a.freq < b.freq
    }
}
