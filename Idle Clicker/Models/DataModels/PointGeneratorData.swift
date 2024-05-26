//
//  PointGeneratorData.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 23/05/2024.
//

import Foundation

class PointGeneratorData: Identifiable, Codable {
    var id: UUID
    var genName: String
    var genPointsPerSecond: Int
    var genPrice: Int
    var genLevel: Int
    
    init(id: UUID = UUID(), genName: String, genPointsPerSecond: Int, genPrice: Int, genLevel: Int) {
        self.id = id
        self.genName = genName
        self.genPointsPerSecond = genPointsPerSecond
        self.genPrice = genPrice
        self.genLevel = genLevel
    }
    
}
