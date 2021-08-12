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
            
            Text(input)
            
            Text(ascii_encoded)
            
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
        var return_val = ""
        for char in input {
            guard let ascii_val = char.asciiValue else { return "Contains invalid character" }
            let binary_ascii_val = String(ascii_val, radix: 2)
            return_val.append(binary_ascii_val)
        }
        return return_val
    }
    
    func huffman_encode(_ input: String) -> String {
        //get frequency of characters in input and store in Node objects
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
            let node = Node(char: char, freq: dict_nodes[char]!)
            heap_nodes.append(node)
        }
        //create min heap of Nodes
        var heap = Heap(elements: heap_nodes, priorityFunction: Node.compare_nodes_maxheap)
        //print results to confirm heap validity
        print("printing heap:")
        print(heap.elements)
        
        print("testing order of output")
        while !heap.isEmpty {
            print(heap.dequeue()?.char as Any)
        }
        
        
        
        return "huffman encoded goes here"
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
