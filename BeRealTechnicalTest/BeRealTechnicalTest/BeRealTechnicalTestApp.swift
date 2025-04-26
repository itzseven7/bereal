//
//  BeRealTechnicalTestApp.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import SwiftUI

@main
struct BeRealTechnicalTestApp: App {
    let userRepository = FileUserRepository(fileURL: Bundle.main.url(forResource: "users", withExtension: "json")!)
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(repository: userRepository, userPageSize: 10))
        }
    }
}
