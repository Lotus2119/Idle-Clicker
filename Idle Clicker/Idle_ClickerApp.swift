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
                .preferredColorScheme(.light)
                .onAppear{
                    setupObservers()
                }
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("App is active")
                gameState.calculateElapsedTimePoints()
            case .inactive:
                print("App is inactive")
                //gameState.saveLastActiveDate()
               // gameState.saveGameState()
            case .background:
                print("App is in background")
                gameState.saveLastActiveDate()
                gameState.saveGameState()
            @unknown default:
                break
            }
        }
        
        
    }
    private func setupObservers() {
        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { _ in
            print("App did enter background")
            gameState.saveLastActiveDate()
            gameState.saveGameState()
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: .main) { _ in
            print("App will resign active")
            gameState.saveLastActiveDate()
            gameState.saveGameState()
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.willTerminateNotification, object: nil, queue: .main) { _ in
            print("App will terminate")
            gameState.saveLastActiveDate()
            gameState.saveGameState()
        }
    }
}
