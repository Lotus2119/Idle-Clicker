//
//  ClickPowerData.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 23/05/2024.
//

import Foundation

class ClickPowerData: Identifiable, Codable {
    var id: UUID
    var clickName: String
    var clickAmount: Int
    var clickPrice: Int
    var clickLevel: Int
    
    init(id: UUID = UUID(), clickName: String, clickAmount: Int, clickPrice: Int, clickLevel: Int) {
        self.id = id
        self.clickName = clickName
        self.clickAmount = clickAmount
        self.clickPrice = clickPrice
        self.clickLevel = clickLevel
    }
}
