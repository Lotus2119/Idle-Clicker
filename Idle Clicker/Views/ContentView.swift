//
//  ContentView.swift
//  Idle Clicker
//
//  Created by Louis Kolodzinski on 23/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab: TabbedItems = .Home
    
    init() {
            // Customize the appearance of the tab bar
        UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray
            UITabBar.appearance().tintColor = UIColor.white
            UITabBar.appearance().backgroundColor = UIColor.clear
        }
    var body: some View {
        
        TabView(selection: $selectedTab){
                            MainView()
                .tag(TabbedItems.Home)
                    .tabItem {
                        Image(systemName: TabbedItems.Home.iconName)
                        Text(TabbedItems.Home.title)
                    }
                
                ProgressionView()
                .tag(TabbedItems.Progress)
                    .tabItem {
                        Image(systemName: TabbedItems.Progress.iconName)
                        Text(TabbedItems.Progress.title)
                    }
                
                SettingsView()
                .tag(TabbedItems.Settings)
                    .tabItem {
                        Image(systemName: TabbedItems.Settings.iconName)
                        Text(TabbedItems.Settings.title)
                    }
            
                
                
            }
        .tint(.white)
        }
    
        
        enum TabbedItems: Int, CaseIterable {
            case Home = 0
            case Progress
            case Settings
            
            var id: Int {self.rawValue}
            
            var title: String {
                switch self {
                case .Home:
                    return "Home"
                case .Progress:
                    return "Progression"
                case .Settings:
                    return "Settings"
                }
            }
            
            var iconName: String {
                switch self {
                case .Home:
                    return "house.fill"
                case .Progress:
                    return "menucard.fill"
                case .Settings:
                    return "gearshape.fill"
                }
            }
        }
        
        // #Preview {
        //    ContentView()
        //       .environmentObject(GameState())
        // }
        
    }
    
    

