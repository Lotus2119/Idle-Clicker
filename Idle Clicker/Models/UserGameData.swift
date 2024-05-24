//
//  UserGameData.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 23/05/2024.
//

import Foundation

struct UserGameData: Codable {
    var userPoints: Int
    var userPointsPerSecond: Int
    var userClickAmount: Int
    
    init(userPoints: Int, userPointsPerSecond: Int, userClickAmount: Int) {
        self.userPoints = userPoints
        self.userPointsPerSecond = userPointsPerSecond
        self.userClickAmount = userClickAmount
    }
    
    enum CodingKeys: CodingKey {
        case userPoints, userPointsPerSecond, userClickAmount
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userPoints = try container.decode(Int.self, forKey: .userPoints)
        userPointsPerSecond = try container.decode(Int.self, forKey: .userPointsPerSecond)
        userClickAmount = try container.decode(Int.self, forKey: .userClickAmount)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userPoints, forKey: .userPoints)
        try container.encode(userPointsPerSecond, forKey: .userPointsPerSecond)
        try container.encode(userClickAmount, forKey: .userClickAmount)
    }
}
