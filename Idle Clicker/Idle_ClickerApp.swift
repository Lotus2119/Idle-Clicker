//
//  Idle_ClickerApp.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 23/05/2024.
//

import SwiftUI

@main
struct Idle_ClickerApp: App {
    @StateObject private var gameState = GameState()
    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameState)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("App is active")
                gameState.calculateElapsedTimePoints()
            case .inactive:
                print("App is inactive")
                //gameState.saveLastActiveDate()
                gameState.saveGameState()
            case .background:
                print("App is in background")
                gameState.saveLastActiveDate()
                gameState.saveGameState()
            @unknown default:
                break
            }
        }
        
    }
}
