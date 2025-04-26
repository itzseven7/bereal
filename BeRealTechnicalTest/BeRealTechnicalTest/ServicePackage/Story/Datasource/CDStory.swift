//
//  CDStory.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import Foundation
import SwiftData

@Model
final class CDStory {
    @Attribute(.unique) var id: UUID
    var date: Date
    var isLiked: Bool
    var isSeen: Bool
    var localURL: URL?
    var remoteURL: URL?
    var userID: Int

    init(date: Date, isLiked: Bool = false, isSeen: Bool = false, localURL: URL? = nil, remoteURL: URL? = nil, userID: Int) {
        self.id = UUID()
        self.date = date
        self.isLiked = isLiked
        self.isSeen = isSeen
        self.localURL = localURL
        self.remoteURL = remoteURL
        self.userID = userID
    }
}
