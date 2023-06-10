//
//  RMEpisodeModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 10.06.2023.
//

import Foundation

// MARK: - Episodes
struct Episodes: Codable {
    let results: [EpisodesResult]
}

// MARK: - Result
struct EpisodesResult: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate
        case episode, characters, url, created
    }
}
