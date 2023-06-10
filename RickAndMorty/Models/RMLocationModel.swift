//
//  RMLocationModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 10.06.2023.
//

import Foundation

// MARK: - Locations
struct Locations: Codable {
    let results: [LocationResult]
}

// MARK: - Result
struct LocationResult: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}
