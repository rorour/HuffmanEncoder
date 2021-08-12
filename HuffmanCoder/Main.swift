//
//  Main.swift
//  HuffmanCoder
//
//  Created by Raven O'Rourke on 8/11/21.
//

import SwiftUI

struct Main: View {
    @State private var input = ""
    @State private var ascii_encoded = ""
    @State private var huffman_encoded = ""

    var body: some View {
        Text("This is the main screen")
        
        VStack {
            HStack {
                Spacer()
                TextField(
                        "Enter the text you want to encode",
                         text: $input
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .border(Color(UIColor.separator))
                    
                Spacer()
            }
            
            Button(action: process_input) {
                Text("Encode")
            }
            
            Text("Original Input:")
            Text(input)
            Text("ASCII:")
            Text(ascii_encoded)
            Text("Huffman:")
            Text(huffman_encoded)
        }
    }
    
    func process_input() {
        //display ascii
        ascii_encoded = ascii_encode(input)
        //encode with huffman and display
        huffman_encoded = huffman_encode(input)
    }
    
    func ascii_encode (_ input: String) -> String {
        var ascii_representation = ""
        for char in input {
            guard let ascii_val = char.asciiValue else { return "Contains invalid character" }
            let binary_ascii_val = String(ascii_val, radix: 2)
            ascii_representation.append(binary_ascii_val)
        }
        return ascii_representation
    }
    
    func get_input_frequency(input: String) -> [Node] {
        //return list of Nodes with freq for each char in input string
        //get frequency of characters in input and store in Node objects (char & freq)
        var dict_nodes: [Character: Int] = [:]
        for char in input {
            if let freq = dict_nodes[char] {
                dict_nodes[char] = freq + 1
            } else {
                dict_nodes[char] = 1
            }
        }
        var heap_nodes = [Node]()
        for char in dict_nodes.keys {
            let node = Node(freq: dict_nodes[char]!, char: char)
            heap_nodes.append(node)
        }
        return heap_nodes
    }
    
    func create_huffman_tree(input: String) -> Node {
        //get list of Nodes (char + frequency for all chars in input)
        let heap_nodes = get_input_frequency(input: input)
        
        //create min heap of Nodes
        var heap = Heap(elements: heap_nodes, priorityFunction: Node.compare_nodes_minheap)
        
        //take 2 minimums, create new node with frequency sum & mins as children. add this node to the min heap and heapify
        while heap.count > 1 {
            let min1 = heap.dequeue()
            let min2 = heap.dequeue()
            let combined_node = Node(freq: min1!.freq + min2!.freq, left_child: min1, right_child: min2)
            heap.enqueue(combined_node)
        }
        //when there is one node, continue
        guard let huffman_tree = heap.dequeue() else {
            print("something went wrong")
            return Node()
        }
        return huffman_tree
    }
    
    func huffman_encode(_ input: String) -> String {
        let huffman_tree = create_huffman_tree(input: input)
        //create key from huffman tree
        var huffman_key: [Character: String] = [:]
        get_huffman_codes(tree: huffman_tree, code_dict: &huffman_key)
        
        print("got \(huffman_key.count) codes added")
        print("printing huffman codes")
        for key in huffman_key.keys {
            print("\(key): \(huffman_key[key]!)")
        }
        
        var encoded: String = ""
        
        for char in input {
            encoded.append(huffman_key[char]!)
        }
        return encoded
    }
    
    func print_leaves(tree: Node, code: String = "") {
        if tree.is_leaf {
            print("\(tree.char ?? "!") \(tree.freq) code: \(code)")
            return
        }
        if let left = tree.left_child {
            print_leaves(tree: left, code: code + "0")
        }
        if let right = tree.right_child {
            print_leaves(tree: right, code: code + "1")
        }
    }
    
    func get_huffman_codes(tree: Node, code: String = "", code_dict: inout [Character: String]) {
        //fill dictionary with huffman codes from tree
        if tree.is_leaf {
            print("\(tree.char ?? "!") \(tree.freq) code: \(code)")
            code_dict[tree.char!] = code
            print("added \(tree.char ?? "!") to code_dict")
            return
        }
        if let left = tree.left_child {
            get_huffman_codes(tree: left, code: code + "0", code_dict: &code_dict)
        }
        if let right = tree.right_child {
            get_huffman_codes(tree: right, code: code + "1", code_dict: &code_dict)
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
