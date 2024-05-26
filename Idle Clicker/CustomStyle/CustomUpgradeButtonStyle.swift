//
//  CustomUpgradeButtonStyle.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 26/05/2024.
//

import SwiftUI

struct CustomUpgradeButtonStyle: ButtonStyle {
    
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 80, height: 80)
            .background(Color("CustomGrey"))
            .cornerRadius(10)
    }
}


