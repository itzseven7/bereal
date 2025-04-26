//
//  HomeViewModel.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import Foundation

final class HomeViewModel: ObservableObject {
    private var allUsers: UserList = .init(pages: [])
    
    @Published
    var users: [User] = []
    
    private var isLoading = false
    
    private let userRepository: UserRepository
    
    private let userPageSize: Int
    private var currentPageIndex: Int? {
        guard allUsers.pages.isEmpty == false else { return nil }
        return users.count % userPageSize
    }

    init(repository: UserRepository, userPageSize: Int) {
        self.userRepository = repository
        self.userPageSize = userPageSize
        
        loadMoreUsers()
    }

    func loadMoreUsers() {
        guard !isLoading else { return }
        isLoading = true
        
        // cancel previous task if needed
        
        Task { @MainActor in
            if self.currentPageIndex == nil {
                self.allUsers = try await self.userRepository.getUsersList()
            }
            
            guard let currentPageIndex = self.currentPageIndex, currentPageIndex < allUsers.pages.count else {
                // all pages are loaded
                return
            }
            
            let nextPage = allUsers.pages[currentPageIndex]
            self.users.append(contentsOf: nextPage.users)
            
            self.isLoading = false
        }
    }
}
