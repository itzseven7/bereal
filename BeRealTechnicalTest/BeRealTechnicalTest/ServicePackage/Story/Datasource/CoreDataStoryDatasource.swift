//
//  CoreDataStoryDatasource.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import Foundation
import SwiftData

protocol StoryLocalDatasource {
    func addStory(_ story: CDStory) throws
    func fetchStories(forUserID userID: Int) throws -> [CDStory]
}

struct CoreDataStoryDatasource: StoryLocalDatasource {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func addStory(_ story: CDStory) throws {
        context.insert(story)
        try context.save()
    }
    
    func fetchStories(forUserID userID: Int) throws -> [CDStory] {
        let descriptor = FetchDescriptor<CDStory>(
            predicate: #Predicate { $0.userID == userID }
        )
        return try context.fetch(descriptor)
    }
}
