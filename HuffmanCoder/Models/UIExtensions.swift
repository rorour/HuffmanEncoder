//
//  UIExtensions.swift
//  HuffmanCoder
//
//  Created by Raven O'Rourke on 8/13/21.
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
