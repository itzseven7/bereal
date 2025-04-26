//
//  StoryList.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import Foundation

public struct StoryPage {
    public let stories: [Story]
    
    public init(stories: [Story]) {
        self.stories = stories
    }
}

public struct StoryList {
    public let pages: [StoryPage]
    
    public init(pages: [StoryPage]) {
        self.pages = pages
    }
}
