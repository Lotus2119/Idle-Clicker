//
//  ContentView.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 23/05/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameState: GameState
    var body: some View {
        VStack {
            Button(action: {
                gameState.click()
            }) {
                Text("Click me")
            }
            .buttonStyle(ClickButtonStyle())
            
            Text("Points: \(gameState.userGameData.userPoints)")
                .onChange(of: gameState.userGameData.userPoints) { newValue in
                    //print("Points updated: \(newValue)")
                }
                .font(.headline)
            Text("Points Per Second: \(gameState.userGameData.userPointsPerSecond)")
                .font(.subheadline)
                
            
            List(gameState.pointsGenerators) { generator in
                HStack {
                    VStack(alignment: .leading) {
                        Text(generator.genName)
                            .font(.headline)
                        Text("Level: \(generator.genLevel)")
                        Text("Price: \(generator.genPrice)")
                        Text("+\(generator.genPointsPerSecond) Points per Second")
                            .font(.footnote)
                    }
                    Spacer()
                    Button(action: {
                        gameState.purchaseGen(generator: generator)
                    }) {
                        Text("Purchase")
                    }
                    .buttonStyle(BorderedButtonStyle())
                    .disabled(gameState.userGameData.userPoints < generator.genPrice)
                }
                
            }
        }
        .padding()
        .onAppear {
            print("ContentView appeared")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GameState())
}
