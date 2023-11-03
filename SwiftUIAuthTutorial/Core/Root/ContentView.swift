//
//  ContentView.swift
//  SwiftUIAuthTutorial
//
//  Created by Lakith Jayalath on 2023-10-31.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                ProfileView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
