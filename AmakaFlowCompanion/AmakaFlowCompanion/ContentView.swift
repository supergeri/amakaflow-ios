//
//  ContentView.swift
//  AmakaFlowCompanion
//
//  Main content view for AmakaFlow Companion iOS app
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .workouts
    
    enum Tab: String {
        case workouts = "Workouts"
        case settings = "Settings"
        
        var icon: String {
            switch self {
            case .workouts:
                return "dumbbell.fill"
            case .settings:
                return "gearshape.fill"
            }
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            WorkoutsView()
                .tabItem {
                    Image(systemName: Tab.workouts.icon)
                }
                .tag(Tab.workouts)
            
            SettingsView()
                .tabItem {
                    Image(systemName: Tab.settings.icon)
                }
                .tag(Tab.settings)
        }
        .tint(Theme.Colors.accentBlue)
    }
}

#Preview {
    ContentView()
        .environmentObject(WorkoutsViewModel())
        .environmentObject(WatchConnectivityManager.shared)
}
