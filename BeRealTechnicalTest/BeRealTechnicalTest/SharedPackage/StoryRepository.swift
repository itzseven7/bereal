//
//  StoryRepository.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import Foundation

public protocol StoryRepository {
    func getStories(forUser user: User) async throws -> [Story]
    func getNewStories(forUser user: User, count: Int) async throws -> [Story]
}
