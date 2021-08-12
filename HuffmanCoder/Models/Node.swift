//
//  Node.swift
//  HuffmanCoder
//
//  Created by Raven O'Rourke on 8/12/21.
//

import Foundation

public class Node {
    var freq: Int = 0
    var char: Character? = nil
    var left_child: Node? = nil
    var right_child: Node? = nil
    var is_leaf: Bool {
        guard left_child == nil else {
            return false
        }
        guard right_child == nil else {
            return false
        }
        return true
    }
    
    public init(freq: Int = 0, char: Character? = nil, left_child: Node? = nil, right_child: Node? = nil) {
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
