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
        //translate to utf 8
        huffman_encoded = huffman_encode(input)
        //encoding algorithm
        ascii_encoded = ascii_encode(input)
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
        return "huffman encoded"
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
