//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 10.06.2023.
//

import Foundation

class RMRequest {
    
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    private let endPoints : RMEndpoints
    private let path : [String]
    private let query : [URLQueryItem]

    init(endPoints: RMEndpoints, path: [String] = [], query: [URLQueryItem] = []) {
        self.endPoints = endPoints
        self.path = path
        self.query = query
    }
    
    private var urlString : String {
        var urlString = Constants.baseURL
        urlString += "/"
        urlString += endPoints.rawValue
        
        if !path.isEmpty {
            path.forEach {
                urlString += "/\($0)"
            }
        }
        
        if !query.isEmpty {
            urlString += "?"
            let compactQuery = query.compactMap ({
                guard let value = $0.value else {return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            urlString += compactQuery
        }
        return urlString
        
    }
    
    var url : URL? {
        return URL(string: urlString)
    } 
}

enum RMEndpoints : String {

    case character
    case location
    case episode
}
