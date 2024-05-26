//
//  DataManager.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 23/05/2024.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private let pointGeneratorsKey = "pointGenerators"
    private let clickPowerKey = "clickPower"
    private let userGameDataKey = "userGameData"
    private let lastActiveTimestampKey = "lastActiveTimestamp"
    private let milestonesKey = "milestones"
    
    // Save PointGenerators
    func savePointGenerators(_ pointGenerators: [PointGeneratorData]) {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(pointGenerators)
            UserDefaults.standard.set(encoded, forKey: pointGeneratorsKey)
            print("PointGenerators saved")
        } catch {
            print("Failed to save point generators: \(error)")
        }
    }
    
    // Load PointGenerators
    func loadPointGenerators() -> [PointGeneratorData] {
        if let savedData = UserDefaults.standard.data(forKey: pointGeneratorsKey) {
            let decoder = JSONDecoder()
            do {
                let loadedPointGenerators = try decoder.decode([PointGeneratorData].self, from: savedData)
                print("PointGenerators loaded")
                return loadedPointGenerators
            } catch {
                print("Failed to load point generators: \(error)")
            }
        }
        print("No PointGenerators found, returning empty array")
        return []
    }
    
    // Save ClickPower
    func saveClickPower(_ clickPower: [ClickPowerData]) {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(clickPower)
            UserDefaults.standard.set(encoded, forKey: clickPowerKey)
            print("ClickPower saved")
        } catch {
            print("Failed to save click power: \(error)")
        }
    }
    
    // Load ClickPower
    func loadClickPower() -> [ClickPowerData] {
        if let savedData = UserDefaults.standard.data(forKey: clickPowerKey) {
            let decoder = JSONDecoder()
            do {
                let loadedClickPower = try decoder.decode([ClickPowerData].self, from: savedData)
                print("ClickPower loaded")
                return loadedClickPower
            } catch {
                print("Failed to load click power: \(error)")
            }
        }
        print("No ClickPower found, returning empty array")
        return []
    }
    
    // Save UserGameData
    func saveUserGameData(_ userGameData: UserGameData) {
        let encoder = JSONEncoder()
        do {
            let encoded = try encoder.encode(userGameData)
            UserDefaults.standard.set(encoded, forKey: userGameDataKey)
            print("UserGameData saved")
        } catch {
            print("Failed to save user game data: \(error)")
        }
    }
    
    // Load UserGameData
    func loadUserGameData() -> UserGameData? {
        if let savedData = UserDefaults.standard.data(forKey: userGameDataKey) {
            let decoder = JSONDecoder()
            do {
                let loadedUserGameData = try decoder.decode(UserGameData.self, from: savedData)
                print("UserGameData loaded")
                return loadedUserGameData
            } catch {
                print("Failed to load user game data: \(error)")
            }
        }
        print("No UserGameData found, returning nil")
        return nil
    }
    
    // Save last active timestamp
    func saveLastActiveDate() {
        let currentDate = Date()
        UserDefaults.standard.set(currentDate, forKey: lastActiveTimestampKey)
        print("Saved last active timestamp: \(currentDate)")
    }
    
    func loadLastActiveDate() -> Date? {
        let lastActiveDate = UserDefaults.standard.object(forKey: lastActiveTimestampKey) as? Date
        print("Loaded last active date: \(String(describing: lastActiveDate))")
        return lastActiveDate
    }
    
    func saveMilestones(_ milestones: [MilestoneManager]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(milestones) {
            UserDefaults.standard.set(encoded, forKey: milestonesKey)
        }
    }
    
    func loadMilestones() -> [MilestoneManager] {
        if let savedData = UserDefaults.standard.data(forKey: milestonesKey) {
            let decoder = JSONDecoder()
            do {
                let loadedMilestones = try
                decoder.decode([MilestoneManager].self, from: savedData)
                print("Milestones loaded")
                return loadedMilestones
            } catch {
                print("Failed to load milestones")
            }
        }
        return[]
    }
   
}
