//
//  RMCharacterModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 10.06.2023.
//

import Foundation

// MARK: - AllCharacters
struct AllCharacters : Codable {
    let info : CharacterInfo
    let results : [Character]
}

// MARK: - CharacterInfo
struct CharacterInfo : Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Characters
struct Character: Codable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: CharacterGender
    let origin: CharacterOrigin
    let location: CharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - Location
struct CharacterLocation: Codable {
    let name: String
    let url: String
}

// MARK: - Origin
struct CharacterOrigin: Codable {
    let name: String
    let url: String
}

enum CharacterGender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
    
    var genderText : String {
        switch self {
        case .female, .male, .genderless:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}

enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var text : String {
        switch self {
        case .alive , .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
