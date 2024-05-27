//
//  MilestonesView.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 26/05/2024.
//

import SwiftUI

struct MilestonesView: View {
    @ObservedObject var milestones: MilestoneManager
    @EnvironmentObject var gameState: GameState
    

    
    var progress: Double {
        let clicks = Double(gameState.userGameData.userClickCount)
        let needed = Double(milestones.milestoneClicksNeeded)
        return max(0, min(clicks / needed, 1.0))
    }
    
    var body: some View {
        ZStack {
            Color("CustomBlue")
                .ignoresSafeArea(.all)
            VStack(alignment: .leading, spacing: 10) {
                Text("Milestone level \(milestones.milestoneLevel)")
                    .fontWeight(.heavy)
                    .font(.headline)
                
                ProgressView(value: progress)
                    .progressViewStyle(CustomProgressBarStyle())
                HStack {
                    Text("Clicks needed: \(milestones.milestoneClicksNeeded)")
                        .font(.subheadline)
                    Spacer()
                    Text("Reward: +\(milestones.milestoneRewards) CPC")
                        .font(.subheadline)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
            .onAppear{
                gameState.checkMilestones(milestones: milestones)
            }
            .onChange(of: gameState.userGameData.userClickCount) {
                gameState.checkMilestones(milestones: milestones)
            }
        }
    }
}

struct MilestoneView_Previews: PreviewProvider {
    static var previews: some View {
        MilestonesView(milestones: MilestoneManager(milestoneLevel: 1, milestoneClicksNeeded: 5000, milestoneRewards: 10))
            .environmentObject(GameState())
    }
}
