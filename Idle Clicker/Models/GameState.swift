//
//  GameState.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 23/05/2024.
//

import Foundation
import Combine


class GameState: ObservableObject {
    @Published var pointsGenerators: [PointGeneratorData]
    @Published var userGameData: UserGameData
    
    private var timer: Timer?
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        print("GameState initialized")
        let loadedPointGenerators = DataManager.shared.loadPointGenerators()
        if loadedPointGenerators.isEmpty {
            self.pointsGenerators = [
                PointGeneratorData(genName: "Points Generator #1", genPointsPerSecond: 1, genPrice: 50, genLevel: 0),
                PointGeneratorData(genName: "Points Generator #2", genPointsPerSecond: 5, genPrice: 500, genLevel: 0),
                PointGeneratorData(genName: "Points Generator #3", genPointsPerSecond: 10, genPrice: 3000, genLevel: 0),
                PointGeneratorData(genName: "Points Generator #4", genPointsPerSecond: 15, genPrice: 10000, genLevel: 0),
                PointGeneratorData(genName: "Points Generator #5", genPointsPerSecond: 20, genPrice: 50000, genLevel: 0)
            ]
        } else {
            self.pointsGenerators = loadedPointGenerators
        }
        
        if let loadedUserGameData = DataManager.shared.loadUserGameData() {
            self.userGameData = loadedUserGameData
        } else {
            self.userGameData = UserGameData(userPoints: 0, userPointsPerSecond: 0, userClickAmount: 1)
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
        let elapsedPoints = Int(elapsedTime) * userGameData.userPointsPerSecond
        userGameData.userPoints += elapsedPoints
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
        userGameData.userPoints += userGameData.userPointsPerSecond
        //saveGameState()
    }
    
    func click() {
       // print("User clicked - incrementing points by \(userGameData.userClickAmount)")
        userGameData.userPoints += userGameData.userClickAmount
        //saveGameState()
    }
    
    func purchaseGen(generator: PointGeneratorData) {
        guard userGameData.userPoints >= generator.genPrice else {
            print("Not enough points to purchase \(generator.genName)")
            return
        }
        
        print("Purchasing \(generator.genName)")
        userGameData.userPoints -= generator.genPrice
        userGameData.userPointsPerSecond += generator.genPointsPerSecond
        
        if let index = pointsGenerators.firstIndex(where: { $0.id == generator.id }) {
            pointsGenerators[index].genLevel += 1
            let level = pointsGenerators[index].genLevel
            if [5, 15, 25, 50, 75, 100].contains(level) {
                pointsGenerators[index].genPrice = Int(Double(pointsGenerators[index].genPrice) * 1.45)
            } else {
                pointsGenerators[index].genPrice = Int(Double(pointsGenerators[index].genPrice) * 1.25)
            }
        } else {
            pointsGenerators.append(generator)
        }
        //saveGameState()
        print("Purchased \(generator.genName)")
    }
    
    func saveGameState() {
        print("Saving game state")
        DataManager.shared.savePointGenerators(pointsGenerators)
        DataManager.shared.saveUserGameData(userGameData)
        print("Game state saved successfully")
    }
}
