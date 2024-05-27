//
//  GameState.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 23/05/2024.
//

import Foundation
import Combine
import SwiftUI


class GameState: ObservableObject {
    @Published var pointsGenerators: [PointGeneratorData]
    @Published var userGameData: UserGameData
    @Published var milestoneManager: [MilestoneManager]
    
    private var timer: Timer?
    private var cancellables: Set<AnyCancellable> = []
    
    
    init() {
        
        print("GameState initialized")
        let loadedPointGenerators = DataManager.shared.loadPointGenerators()
        if loadedPointGenerators.isEmpty {
            self.pointsGenerators = [
                PointGeneratorData(genName: "Points Generator #1", genPointsPerSecond: 1, genPrice: LargeNumber(50), genLevel: 0, genPrestigeLevel: 0),
                PointGeneratorData(genName: "Points Generator #2", genPointsPerSecond: 5, genPrice: LargeNumber(300), genLevel: 0, genPrestigeLevel: 0),
                PointGeneratorData(genName: "Points Generator #3", genPointsPerSecond: 10, genPrice: LargeNumber(2000), genLevel: 0, genPrestigeLevel: 0),
                PointGeneratorData(genName: "Points Generator #4", genPointsPerSecond: 20, genPrice: LargeNumber(15000), genLevel: 0, genPrestigeLevel: 0),
                PointGeneratorData(genName: "Points Generator #5", genPointsPerSecond: 50, genPrice: LargeNumber(100000), genLevel: 0, genPrestigeLevel: 0)
            ]
        } else {
            self.pointsGenerators = loadedPointGenerators
        }
        
        let loadedMilestones = DataManager.shared.loadMilestones()
        if loadedMilestones.isEmpty {
            self.milestoneManager = [
            MilestoneManager(milestoneLevel: 1, milestoneClicksNeeded: 250, milestoneRewards: 1)
            ]
        } else {
            self.milestoneManager = loadedMilestones
        }
        
        
        
        if let loadedUserGameData = DataManager.shared.loadUserGameData() {
            self.userGameData = loadedUserGameData
        } else {
            self.userGameData = UserGameData(userPoints: LargeNumber(0), userPointsPerSecond: 0, userClickAmount: 1, userClickCount: 0)
        }
        
        calculateElapsedTimePoints()
        startTimer()
        
        NotificationCenter.default.publisher(for: .appWillTerminate)
            .sink { [weak self] _ in
                print("GameState: App will terminate notification received")
                self?.saveLastActiveDate()
                self?.saveGameState()
            }
            .store(in: &cancellables)
    }
    
    func saveLastActiveDate() {
        print("Saving last active timestamp")
        DataManager.shared.saveLastActiveDate()
    }
    
    /*func calculateElapsedTimePoints() {
        print("Calculating elapsed time points")
        let previousPoints = userGameData.userPoints
        DataManager.shared.calculateElapsedTimePoints(for: &self.userGameData)
        let newPoints = userGameData.userPoints
        print("Previous points: \(previousPoints)")
        print("New points: \(newPoints)")
    }*/
    
    func calculateElapsedTimePoints() {
        guard let lastActiveDate = DataManager.shared.loadLastActiveDate() else {
            print("No valid last active date found")
            return
        }
        let currentDate = Date()
        let elapsedTime = currentDate.timeIntervalSince(lastActiveDate)
        let elapsedPoints = LargeNumber(Double(elapsedTime) * Double(userGameData.userPointsPerSecond))
        userGameData.userPoints.add(elapsedPoints)
        print("Last active date: \(lastActiveDate)")
        print("Current date: \(currentDate)")
        print("Elapsed time: \(elapsedTime) seconds")
        print("Elapsed points: \(elapsedPoints)")
        print("New user points: \(userGameData.userPoints)")

    }
    
    
    func startTimer() {
        print("Starting timer")
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }
    
    func tick() {
        //print("Timer tick - incrementing points")
        userGameData.userPoints.add(userGameData.userPointsPerSecond)
        
    }
    
    func click() {
       //print("User clicked - incrementing points by \(userGameData.userClickAmount)")
        userGameData.userPoints.add(userGameData.userClickAmount)
        //saveGameState()
        clickCount()
        
    }
    
    func clickCount() {
        userGameData.userClickCount += 1
    }
    
    func checkMilestones(milestones: MilestoneManager){
        for milestones in milestoneManager {
            if userGameData.userClickCount >= milestones.milestoneClicksNeeded {
                userGameData.userClickAmount += milestones.milestoneRewards
                userGameData.userClickCount = 0
                milestones.milestoneLevel += 1
                milestones.milestoneClicksNeeded = milestones.milestoneClicksNeeded * 5
                milestones.milestoneRewards = milestones.milestoneRewards * 5
            }
        }
    }
    
    func purchaseGen(generator: PointGeneratorData) {
        guard userGameData.userPoints >= generator.genPrice else {
            print("Not enough points to purchase \(generator.genName)")
            return
        }
        
        print("Purchasing \(generator.genName)")
        userGameData.userPoints.subtract(generator.genPrice)
        userGameData.userPointsPerSecond += generator.genPointsPerSecond
        
        if let index = pointsGenerators.firstIndex(where: { $0.id == generator.id }) {
            pointsGenerators[index].genLevel += 1
            let level = pointsGenerators[index].genLevel
            if [5, 15, 25, 50, 75, 100].contains(level) {
                pointsGenerators[index].genPrice = pointsGenerators[index].genPrice * 2.0
            } else {
                pointsGenerators[index].genPrice = pointsGenerators[index].genPrice * 1.15
            }
        } else {
            pointsGenerators.append(generator)
        }
        //saveGameState()
        print("Purchased \(generator.genName)")
    }
    
    func prestigeGen(generator: PointGeneratorData) {
        generator.genLevel = 0
        generator.genPrestigeLevel += 1
        generator.genPointsPerSecond += generator.genPrestigeLevel  * 2
        generator.genPrice = generator.genPrice * 1.5
        
        objectWillChange.send()
            
    }
    func levelColor(for generator: PointGeneratorData) -> Color {
        switch generator.genPrestigeLevel {
        case 0:
            return Color.gray
        case 1:
            return Color("CustomBronze")
        case 2:
            return Color("CustomSilver")
        case 3:
            return Color("CustomGold")
        default:
            return Color.gray
        }
    }
    
    func saveGameState() {
        let data = try? JSONEncoder().encode(userGameData)
                if let dataSize = data?.count {
                    print("Data size: \(dataSize) bytes")
                    if dataSize > 50_000 { // Example threshold (50 KB)
                        print("Warning: Data size is too large for UserDefaults")
                        // Consider alternative storage here
                    }
                }

        print("Saving game state")
        DataManager.shared.savePointGenerators(pointsGenerators)
        DataManager.shared.saveUserGameData(userGameData)
        DataManager.shared.saveMilestones(milestoneManager)
        print("Game state saved successfully")
    }
    func resetAllGameData() {
        self.userGameData = UserGameData(userPoints: LargeNumber(0), userPointsPerSecond: 0, userClickAmount: 1, userClickCount: 0)
        self.pointsGenerators = [
            PointGeneratorData(genName: "Points Generator #1", genPointsPerSecond: 1, genPrice: LargeNumber(50), genLevel: 0, genPrestigeLevel: 0),
            PointGeneratorData(genName: "Points Generator #2", genPointsPerSecond: 5, genPrice: LargeNumber(300), genLevel: 0, genPrestigeLevel: 0),
            PointGeneratorData(genName: "Points Generator #3", genPointsPerSecond: 10, genPrice: LargeNumber(2000), genLevel: 0, genPrestigeLevel: 0),
            PointGeneratorData(genName: "Points Generator #4", genPointsPerSecond: 20, genPrice: LargeNumber(15000), genLevel: 0, genPrestigeLevel: 0),
            PointGeneratorData(genName: "Points Generator #5", genPointsPerSecond: 50, genPrice: LargeNumber(100000), genLevel: 0, genPrestigeLevel: 0)
        ]
        self.milestoneManager = [
            MilestoneManager(milestoneLevel: 1, milestoneClicksNeeded: 100, milestoneRewards: 10)
        ]
        print("User game data reset")
    }
    
    
    }
    
    
      
        
    
    

