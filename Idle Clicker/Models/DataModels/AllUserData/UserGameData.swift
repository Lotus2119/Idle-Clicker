//
//  UserGameData.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 23/05/2024.
//

import Foundation

struct UserGameData: Codable {
    var userPoints: LargeNumber
    var userPointsPerSecond: Int
    var userClickAmount: Int
    var userClickCount: Int
    
    enum CodingKeys: CodingKey {
            case userPoints, userPointsPerSecond, userClickAmount, userClickCount
        }
        
        init(userPoints: LargeNumber, userPointsPerSecond: Int, userClickAmount: Int, userClickCount: Int) {
            self.userPoints = userPoints
            self.userPointsPerSecond = userPointsPerSecond
            self.userClickAmount = userClickAmount
            self.userClickCount = userClickCount
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            userPoints = try container.decode(LargeNumber.self, forKey: .userPoints)
            userPointsPerSecond = try container.decode(Int.self, forKey: .userPointsPerSecond)
            userClickAmount = try container.decode(Int.self, forKey: .userClickAmount)
            userClickCount = try container.decode(Int.self, forKey: .userClickCount)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(userPoints, forKey: .userPoints)
            try container.encode(userPointsPerSecond, forKey: .userPointsPerSecond)
            try container.encode(userClickAmount, forKey: .userClickAmount)
            try container.encode(userClickCount, forKey: .userClickCount)
        }
    }
