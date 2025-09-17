//
//  syGroupTaskApp.swift
//  syGroupTask
//
//  Created by Amritesh Kumar on 02/09/25.
//

import SwiftUI

@main
struct syGroupTaskApp: App {
    @State private var showSplash: Bool = true
    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView {
                    withAnimation(.easeInOut(duration: 0.3)) { showSplash = false }
                }
            } else {
                ContentView()
            }
        }
    }
}
