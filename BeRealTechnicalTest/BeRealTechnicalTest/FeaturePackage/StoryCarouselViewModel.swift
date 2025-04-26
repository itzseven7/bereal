//
//  StoryCarouselViewModel.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import Foundation

@MainActor
final class StoryCarouselViewModel: ObservableObject {
    @Published var stories: [Story] = []
    
    @Published var currentIndex: Int = 0
    @Published var progress: Double = 0.0
    
    var timer: Timer?
    let duration: TimeInterval = 5.0
    
    private let repository: StoryRepository
    private let user: User

    init(repository: StoryRepository, user: User) {
        self.repository = repository
        self.user = user
        
        startTimer()
    }
    
    func load() async {
        do {
            let stories = try await repository.getStories(forUser: user)
            self.stories = stories
        } catch {
            
        }
    }
    
    func imageData(for story: Story) -> Data {
        do {
            return try Data(contentsOf: story.contentURL)
        } catch {
            return Data()
        }
    }

    func likeCurrentStory() {
        stories[currentIndex].isLiked.toggle()
    }
    
    func markViewed(index: Int) {
        if !stories[index].isSeen {
            stories[index].isSeen = true
        }
    }
    
    func nextStory() {
        if currentIndex < stories.count - 1 {
            currentIndex += 1
            markViewed(index: currentIndex)
            resetTimer()
        } else {
            resetTimer()
        }
    }
    
    func previousStory() {
        if currentIndex > 0 {
            currentIndex -= 1
            markViewed(index: currentIndex)
            resetTimer()
        }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.progress += 0.05 / self.duration
            if self.progress >= 1.0 {
                self.progress = 0.0
                self.nextStory()
            }
        }
    }

    func resetTimer() {
        timer?.invalidate()
        progress = 0.0
        startTimer()
    }

    deinit {
        timer?.invalidate()
    }
}
