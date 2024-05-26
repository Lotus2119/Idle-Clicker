//
//  MilestoneManager.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 26/05/2024.
//

import Foundation

class MilestoneManager: Identifiable, ObservableObject, Codable {
    var id: UUID
    var milestoneLevel: Int
    var milestoneClicksNeeded: Int
    var milestoneRewards: Int
    
    
    init(id: UUID = UUID(), milestoneLevel: Int, milestoneClicksNeeded: Int, milestoneRewards: Int) {
        self.id = id
        self.milestoneLevel = milestoneLevel
        self.milestoneClicksNeeded = milestoneClicksNeeded
        self.milestoneRewards = milestoneRewards
        
    }
}
