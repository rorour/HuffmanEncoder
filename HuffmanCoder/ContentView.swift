//
//  ContentView.swift
//  HuffmanCoder
//
//  Created by Raven O'Rourke on 8/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Main()
            .preferredColorScheme(.dark)
            .font(Font.custom("Helvetica", size: 20))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
