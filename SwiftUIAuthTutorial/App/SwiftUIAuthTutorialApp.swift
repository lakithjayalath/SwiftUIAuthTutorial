//
//  SwiftUIAuthTutorialApp.swift
//  SwiftUIAuthTutorial
//
//  Created by Lakith Jayalath on 2023-10-31.
//

import SwiftUI
import Firebase

@main
struct SwiftUIAuthTutorialApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
