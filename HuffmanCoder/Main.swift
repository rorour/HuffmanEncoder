//
//  Main.swift
//  HuffmanCoder
//
//  Created by Raven O'Rourke on 8/11/21.
//

import SwiftUI

extension Color {
    static let background = Color.black
    static let accent1 = Color.white
    static let accent2 = Color.white.opacity(0.1)
    static let accent3 = Color.white.opacity(0.15)
    static let border = accent2
    static let title = accent1
    static let button = Color.white.opacity(0.4)
    static let button_pressed = Color.white.opacity(0.6)
    static let text = Color.white
}

struct EncodeButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(5)
            .foregroundColor(Color.black)
            .background(RoundedRectangle(cornerRadius: 5)
                            .fill(configuration.isPressed ? Color.button_pressed : Color.button)
            )
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}

struct Main: View {
    @State private var input = ""
    @State private var ascii_encoded = ""
    @State private var huffman_encoded = ""
    @State private var huffman_code_key = ""
    @State private var valid_input: Bool = true
    
    struct TextBoxView: View {
        var title: String
        var content: String
        var geometry: GeometryProxy
        var body: some View {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.footnote)
                    .background(Color.accent3)
                ScrollView {
                    Text(content)
                }
                .padding(5)
                .frame(width: geometry.size.width * 0.9, height: 100, alignment: .leading)
                .border(Color.border, width: 2)
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
                        Color.background
                            .ignoresSafeArea()
            VStack {
                Text("")
                Text("Huffman Coder")
                    .font(Font.custom("Helvetica", size: 40))
                    .bold()
                    .foregroundColor(Color.title)
                Text("\n")
                
                HStack {
                    Spacer()
                    TextField(
                        "Enter the text you want to encode",
                        text: $input
                    )
                    .padding(5)
//                    .placeholder(when: input.isEmpty) {
//                            Text("Placeholder recreated").foregroundColor(.gray)
//                    }
                    .frame(width: geometry.size.width * 0.9)
                    .foregroundColor(Color.text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .border(Color(UIColor.separator))
                    Spacer()
                }
                
                HStack {
                    Spacer()

                    Button(action: process_input) {
                        Text("Encode")
                    }
                    .buttonStyle(EncodeButtonStyle())
                }
                .frame(width: geometry.size.width * 0.9)

                Text("")
                
                TextBoxView(title: "ASCII Encoding (\(ascii_encoded.count) bits):", content: ascii_encoded, geometry: geometry)
                
                TextBoxView(title: "Huffman Encoding (\(huffman_encoded.count) bits):", content: huffman_encoded, geometry: geometry)
                
                TextBoxView(title: "Huffman Code Key", content: huffman_code_key, geometry: geometry)
                
            }
        }
    }
    
    func process_input() {
        huffman_code_key = ""
        guard input.count > 0 else {
            ascii_encoded = ""
            huffman_encoded = ""
            return
        }
        ascii_encoded = ascii_encode(input)
        guard valid_input else { //if contains non-ascii character
            huffman_encoded = ""
            return
        }
        huffman_encoded = huffman_encode(input)
    }
    
    func ascii_encode (_ input: String) -> String {
        valid_input = true
        var ascii_representation = ""
        for char in input {
            guard let ascii_val = char.asciiValue else {
                valid_input = false
                return "Error: Contains non-ASCII character"
            }
            let binary_ascii_val = String(ascii_val, radix: 2)
            ascii_representation.append(binary_ascii_val)
        }
        return ascii_representation
    }
    
    func huffman_encode(_ input: String) -> String {
        let huffman_tree = create_huffman_tree(input: input)
        //create key from huffman tree
        var huffman_key: [Character: String] = [:]
        if huffman_tree.is_leaf {
            //if only one character, assign 0 as code
            if let letter = huffman_tree.char {
                huffman_key[letter] = "0"
            }
        } else {
            get_huffman_codes(tree: huffman_tree, code_dict: &huffman_key)
        }
        
        var encoded: String = ""
        
        for char in input {
            encoded.append(huffman_key[char]!)
        }
        
        //create key string
        for key in huffman_key.keys {
            huffman_code_key.append("\(key): \(huffman_key[key]!)\n")
        }
        return encoded
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
            print("Error: No input found")
            return Node()
        }
        return huffman_tree
    }
    
    func print_leaves(tree: Node, code: String = "") {
        if tree.is_leaf {
            print("\(tree.char!) \(tree.freq) code: \(code)")
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
            code_dict[tree.char!] = code
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
