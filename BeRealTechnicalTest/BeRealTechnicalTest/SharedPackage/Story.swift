//
//  Story.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import Foundation

public struct Story {
    public let id: UUID
    public let date: Date
    public let contentURL: URL
    public var isSeen: Bool
    public var isLiked: Bool
    
    public init(id: UUID, date: Date, contentURL: URL, isSeen: Bool, isLiked: Bool) {
        self.id = id
        self.date = date
        self.contentURL = contentURL
        self.isSeen = isSeen
        self.isLiked = isLiked
    }
}
