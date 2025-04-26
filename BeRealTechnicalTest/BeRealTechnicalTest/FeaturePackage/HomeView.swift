//
//  HomeView.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    
    @ObservedObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    @State private var showingSheet = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Instagram like")
                .font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(viewModel.users) { user in
                        UserItemView(user: user)
                            .onAppear {
                                if user == viewModel.users.last {
                                    viewModel.loadMoreUsers()
                                }
                            }
                            .onTapGesture {
                                viewModel.selectedUser = user
                                showingSheet = true
                            }
                    }
                }
                .padding(.vertical, 10)
            }
            Spacer()
        }
        .sheet(isPresented: $showingSheet, onDismiss: {
//            selectedUser = nil
//            showingSheet = false
        }, content: {
            storyView()
        })
        .padding()
    }
    
    @ViewBuilder
    private func storyView() -> some View {
        if let selectedUser = viewModel.selectedUser {
            StoryCarouselView(
                viewModel: StoryCarouselViewModel(
                    repository: LiveStoryRepository(
                        localDatasource: CoreDataStoryDatasource(
                            context: modelContext
                        ),
                        remoteDatasource: PicsumRemoteDatasource(
                            screenSize: UIScreen.main.bounds.size
                        )
                    ),
                    user: selectedUser
                )
            )
        } else {
            EmptyView()
        }
    }
}

#if DEBUG

struct MockedRepository: UserRepository {
    func getUsersList() async throws -> UserList {
        UserList(
            pages: [
                UserPage(users: [
                    User(id: 1, name: "Romain", profilePictureURL: URL(string: "https://i.pravatar.cc/300?u=1")!),
                    User(id: 2, name: "Romain", profilePictureURL: URL(string: "https://i.pravatar.cc/300?u=2")!),
                    User(id: 3, name: "Romain", profilePictureURL: URL(string: "https://i.pravatar.cc/300?u=3")!)
                ]),
                UserPage(users: [
                    User(id: 4, name: "Romain", profilePictureURL: URL(string: "https://i.pravatar.cc/300?u=4")!),
                    User(id: 5, name: "Romain", profilePictureURL: URL(string: "https://i.pravatar.cc/300?u=5")!),
                    User(id: 6, name: "Romain", profilePictureURL: URL(string: "https://i.pravatar.cc/300?u=6")!)
                ])
            ]
        )
    }
}

#endif

#Preview {
    HomeView(
        viewModel: HomeViewModel(
            repository: MockedRepository(),
            userPageSize: 3
        )
    )
}
