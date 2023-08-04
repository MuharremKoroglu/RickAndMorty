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
    let info : EpisodesInfo
}

// MARK: - EpisodesInfo
struct EpisodesInfo : Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct EpisodesResult: Codable {
    let id: Int
    let name: String
    let date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, url, created
        case date = "air_date"
    }
}
