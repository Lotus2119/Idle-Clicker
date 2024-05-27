//
//  MainView.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 27/05/2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var gameState: GameState
    
    var body: some View {
        ZStack {
            Color("CustomBlue")
                .ignoresSafeArea(.all)
            
            VStack {
                Text("Points: \(gameState.userGameData.userPoints.description)")
                    .onChange(of: gameState.userGameData.userPoints.description) { newValue in
                        //print("Points updated: \(newValue)")
                    }
                    .font(.headline)
                    .fontDesign(.monospaced)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                HStack {
                    Text("+\(gameState.userGameData.userPointsPerSecond) PPS")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                    Text("\(gameState.userGameData.userClickAmount) CPC")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                }
                
                Button(action: {
                    gameState.click()
                }) {
                    Text("Click me")
                }
                .buttonStyle(ClickButtonStyle())
                
                ForEach(gameState.milestoneManager) { milestone in
                    MilestonesView(milestones: milestone)
                        .environmentObject(gameState)
                }
                
                HStack {
                    Button(action: {
                        gameState.userGameData.userPoints.add(1000000000000000000)
                    }) {
                        Text("debug + points")
                    }
                    .buttonStyle(BorderedButtonStyle())
                    
                    Button(action: {
                        gameState.resetAllGameData()
                    }) {
                        Text("debug - reset data")
                    }
                    .buttonStyle(BorderedButtonStyle())
                }
                
                // Make the ScrollView take up remaining space
                ScrollView {
                    VStack(spacing: 5) {
                        ForEach(gameState.pointsGenerators) { generator in
                            PointGeneratorView(generator: generator)
                                .environmentObject(gameState)
                                .onAppear {
                                    print("PointGeneratorView for \(generator.genName) appeared with points \(gameState.userGameData.userPoints)")
                                }
                        }
                    }
                    .padding(.bottom, 20) // Optional: Add some padding at the bottom if needed
                }
                
            }
            .padding()
            .onAppear {
                print("ContentView appeared")
            }
        }
        
    }
}

#Preview {
    MainView()
        .environmentObject(GameState())
}
