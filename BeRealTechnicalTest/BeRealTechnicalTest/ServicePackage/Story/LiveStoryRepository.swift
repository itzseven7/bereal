//
//  LiveStoryRepository.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import UIKit
import SwiftData

struct LiveStoryRepository: StoryRepository {
    
    let localDatasource: StoryLocalDatasource
    let remoteDatasource: StoryRemoteDatasource
    
    func getStories(forUser user: User) async throws -> [Story] {
        var stories = try getLocalStories(forUser: user)
        
        if stories.isEmpty == true {
            stories = try await getNewStories(forUser: user, count: 10)
        }
        
        return stories
    }
    
    private func getLocalStories(forUser user: User) throws -> [Story] {
        let existingStories = try localDatasource.fetchStories(forUserID: user.id)
        
        return try existingStories.map(CDStoryConverter.convert)
    }
    
    func getNewStories(forUser user: User, count: Int) async throws -> [Story] {
        let newStories = try await remoteDatasource.getNewStories(count: count)
        
        guard let cacheDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return []
        }
        
        var stories: [Story] = []
        
        for newStory in newStories {
            let persistedStory = CDStory(
                date: Date(),
                isLiked: false,
                isSeen: false,
                localURL: nil,
                remoteURL: nil,
                userID: user.id
            )
            
            let fileURL = cacheDirectoryURL.appending(path: "story_\(persistedStory.id.uuidString)")
            persistedStory.localURL = fileURL
            
            try localDatasource.addStory(persistedStory)
            try newStory.write(to: fileURL)
            
            stories.append(try CDStoryConverter.convert(story: persistedStory))
        }
        
        return stories
    }
}

struct CDStoryConverter {
    static func convert(story: CDStory) throws -> Story {
        guard let url = story.localURL else {
            throw Error.invalidURL
        }
        
        return .init(
            id: story.id,
            date: story.date,
            contentURL: url,
            isSeen: story.isSeen,
            isLiked: story.isLiked
        )
    }
    
    enum Error: Swift.Error {
        case invalidURL
    }
}
