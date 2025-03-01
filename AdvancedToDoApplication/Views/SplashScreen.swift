//
//  SplashScreen.swift
//  AdvancedToDoApplication
//
//  Created by Tyler O'Neil on 2025-02-27.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            TaskBoardView()
        } else {
            VStack {
                Text("Advanced To-Do App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 100)
                Text("Cheuk Man Sit, 101422756")
                    .font(.subheadline)
                    .padding(.top, 20)
                Text("Tyler O'Neil, 101434244")
                    .font(.subheadline)
                    .padding(.top, 10)

                Spacer()

                Button("Tap to Continue") {
                    isActive = true
                }
                .font(.title2)
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    SplashScreen()
}
