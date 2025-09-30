//
//  DayMeal.swift
//  ChickenSpice
//
//  Created by Алексей Авер on 29.09.2025.
//


import SwiftUI

struct RootView: View {
    
    @StateObject private var state = AppStateManager()
    @StateObject private var fcmManager = FCMManager.shared
        
    var body: some View {
        Group {
            switch state.appState {
            case .fetch:
                loadScreen
                
            case .support:
                if let url = state.webManager.targetURL {
                    WebViewManager(url: url, webManager: state.webManager)
                } else if let fcmToken = fcmManager.fcmToken {
                    WebViewManager(
                        url: NetworkManager.getInitialURL(fcmToken: fcmToken),
                        webManager: state.webManager
                    )
                } else {
                    WebViewManager(
                        url: NetworkManager.initialURL,
                        webManager: state.webManager
                    )
                }
                
            case .final:
                ContentView()
                    .preferredColorScheme(.light)
            }
        }
        .onAppear {
            state.stateCheck()
        }
    }
    
    private var loadScreen: some View {
        ZStack {
            Image("backStart")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Image(.logoStart)
                Spacer()
                ProgressView()
                    .scaleEffect(1.5)
                Text("Please wait...")
                    .foregroundStyle(.white)
                    .padding(.bottom, 46)
                    .font(.custom(.MontserratRegular, size: 18))
            }
        }
    }
}

#Preview {
    RootView()
}
