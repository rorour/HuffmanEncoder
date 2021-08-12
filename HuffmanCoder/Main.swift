//
//  Main.swift
//  HuffmanCoder
//
//  Created by Raven O'Rourke on 8/11/21.
//

import SwiftUI

struct Main: View {
    @State private var input = ""
    @State private var utf_8_encoded = ""
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
            
            Text(utf_8_encoded)
            
            Text(huffman_encoded)
        }
    }
    
    func process_input() {
        //translate to utf 8
        huffman_encoded = huffman_encode(input)
        //encoding algorithm
        utf_8_encoded = utf_8_encode(input)
    }
    
    func utf_8_encode (_ input: String) -> String {
        return "utf 8 encoded"
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
