//
//  textField.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 11.06.2022.
//

import SwiftUI

struct NeumorphicStyleTextField: View {
    var textField: TextField<Text>
    var body: some View {
        HStack {
            textField
            }
            .padding()
            .foregroundColor(.neumorphictextColor)
            .background(Color.background)
            .cornerRadius(20)
            .shadow(color: Color.yellow.opacity(0.5), radius: 5, x: 5, y: 5)
            .shadow(color: Color.blue.opacity(0.5), radius: 5, x: -5, y: -5)
//            .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
//            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
            
        }
}
