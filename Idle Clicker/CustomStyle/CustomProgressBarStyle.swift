//
//  CustomProgressBarStyle.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 27/05/2024.
//

import Foundation
import SwiftUI

struct CustomProgressBarStyle: ProgressViewStyle {
    func makeBody (configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(width: 300, height: 10)
                .cornerRadius(5)
                .opacity(1)
                .foregroundColor(Color("CustomGrey"))
            Rectangle()
                .frame(width: 300 * CGFloat(configuration.fractionCompleted ?? 0.0), height: 10)
                .cornerRadius(5)
                .foregroundColor(Color("CustomBlue"))
        }
    }
}
