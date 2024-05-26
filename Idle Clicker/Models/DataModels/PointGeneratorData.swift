//
//  PointGeneratorData.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 23/05/2024.
//

import Foundation

class PointGeneratorData: Identifiable, ObservableObject, Codable {
    var id: UUID
    var genName: String
    var genPointsPerSecond: Int
    var genPrice: LargeNumber
    var genLevel: Int
    var genPrestigeLevel: Int
    
    init(id: UUID = UUID(), genName: String, genPointsPerSecond: Int, genPrice: LargeNumber, genLevel: Int, genPrestigeLevel: Int) {
        self.id = id
        self.genName = genName
        self.genPointsPerSecond = genPointsPerSecond
        self.genPrice = genPrice
        self.genLevel = genLevel
        self.genPrestigeLevel = genPrestigeLevel
    }
    
}
