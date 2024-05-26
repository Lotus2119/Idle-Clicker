//
//  PointGeneratorView.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 26/05/2024.
//

import SwiftUI
import Combine

struct PointGeneratorView: View {
    @EnvironmentObject var gameState: GameState
    @ObservedObject var generator: PointGeneratorData
    
    @State private var animate = false
    
    
    
    var body: some View {
        ZStack {
            Color("CustomBlue")
                .ignoresSafeArea(.all)
            
            
            HStack {
                VStack{
                    Text("\(generator.genLevel)")
                        .fontDesign(.monospaced)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding(.trailing, 8)
                        .foregroundColor(gameState.levelColor(for: generator))
                    
                    Text("LVL")
                        .fontWeight(.heavy)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text(generator.genName)
                        .font(.headline)
                        .fontWeight(.heavy)
                    
                    
                    Text("Price: \(generator.genPrice.description)")
                        .fontDesign(.rounded)
                    
                    Text("+\(generator.genPointsPerSecond) Points per Second")
                        .font(.caption2)
                        .fontDesign(.rounded)
                    if generator.genPrestigeLevel >= 1 {
                        Text("Prestige level: \(generator.genPrestigeLevel)")
                    }
                    
                }
                Spacer()
                
                if generator.genLevel < 99 {
                    Button(action: {
                        gameState.purchaseGen(generator: generator)
                        updateAnimationState()
                    }) {
                        Image(systemName: "arrowshape.up.fill")
                            .foregroundColor(animate ? Color("CustomBlue") : Color.gray)
                            .font(.system(size: 35))
                        /*.scaleEffect(scale)
                         .opacity(opacity)
                         .animation(.easeInOut(duration: 0.5), value: scale)
                         .animation(.easeInOut(duration: 0.5), value: opacity)*/
                            .opacity(animate ? 1 : 0.5)
                            .scaleEffect(animate ? 1.2 : 1.0)
                            .animation(animate ? Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true) : .default, value: animate)
                            
                        
                    }
                    
                    //.symbolEffect(.pulse, options: animate ? .repeating : .nonRepeating, value: animate)
                    //.symbolEffect(.bounce, options: animate ? .repeating : .nonRepeating , value: animate)
                    
                    
                    //Text("LVL")
                    .buttonStyle(CustomUpgradeButtonStyle())
                    .disabled(gameState.userGameData.userPoints.toIntSafe() < generator.genPrice.toIntSafe())
                } else {
                    Button(action: {
                        gameState.prestigeGen(generator: generator)
                        updateAnimationState()
                    }) {
                        Image(systemName: "exclamationmark.arrow.triangle.2.circlepath")
                            .foregroundColor(.red)
                            .font(.system(size: 35))
                        
                    }
                    .buttonStyle(CustomUpgradeButtonStyle())
                    .disabled(gameState.userGameData.userPoints.toIntSafe() < generator.genPrice.toIntSafe())
                    
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
            .onAppear{
                updateAnimationState()
               
            }
            
        
            .onChange(of: gameState.userGameData.userPoints.description) { _ in
                //print("userPoints changed:")
              updateAnimationState()
            }
            .onChange(of: generator.genPrestigeLevel) { _ in
                updateAnimationState()
            }
            
            
        }
        //.onAppear {
           // print("PointGeneratorView for \(generator.genName) appeared with points \(gameState.userGameData.userPoints)")        }
        
    }
    
    
    private func updateAnimationState() {
        let shouldAnimate = gameState.userGameData.userPoints.toIntSafe() >= generator.genPrice.toIntSafe()
            animate = shouldAnimate
        }
    
    
    
}



    


struct PointGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        PointGeneratorView(generator: PointGeneratorData(
            genName: "Points Generator #1",
            genPointsPerSecond: 1,
            genPrice: LargeNumber(50),
            genLevel: 0,
            genPrestigeLevel: 0
        ))
        .environmentObject(GameState())
    }
}
