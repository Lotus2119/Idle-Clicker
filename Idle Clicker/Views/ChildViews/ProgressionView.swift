//
//  ProgressionView.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 27/05/2024.
//

import SwiftUI

struct ProgressionView: View {
    @EnvironmentObject var gameState: GameState
    
    var body: some View {
        ZStack{
            Color("CustomBlue")
                .ignoresSafeArea(.all)
            VStack{
                ForEach(gameState.milestoneManager) { milestone in
                    MilestonesView(milestones: milestone)
                        .environmentObject(gameState)
                }
            }
        }
    }
}

#Preview {
    ProgressionView()
}
