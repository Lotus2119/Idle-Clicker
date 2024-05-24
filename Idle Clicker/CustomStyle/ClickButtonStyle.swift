//
//  ClickButtonStyle.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 24/05/2024.
//

import SwiftUI

struct ClickButtonStyle:  ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 300, height: 300)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(30)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
            
    }
}
