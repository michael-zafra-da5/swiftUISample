//
//  SwiftUISampleApp.swift
//  SwiftUISample
//
//  Created by Michael Angelo Zafra on 1/17/22.
//

import SwiftUI
import Firebase

@main
struct SwiftUISampleApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            let viewModel = LoginViewModel()
            LoginView()
                .environmentObject(viewModel)
        }
    }
}
