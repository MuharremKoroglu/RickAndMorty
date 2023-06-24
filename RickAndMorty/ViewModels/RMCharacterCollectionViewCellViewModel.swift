//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 24.06.2023.
//

import Foundation

class RMCharacterCollectionViewCellViewModel {
    
    public let characterName : String
    private let characterStatus : CharacterStatus
    private let characterGender : CharacterGender
    private let characterImage : URL?
    
    init(characterName : String, characterStatus : CharacterStatus, characterGender : CharacterGender,characterImage : URL?) {
        self.characterImage = characterImage
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterGender = characterGender
    }
    
    public var characterStatusText : String {
        return "Status : \(characterStatus.text)"
    }
    
    public var characterGenderText : String {
        return characterGender.genderText
    }
    
    
    public func fetchImage (completion : @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = characterImage else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let serverResponse = response as? HTTPURLResponse, serverResponse.statusCode == 200 else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard let data = data, error == nil else {
                completion(.failure(URLError(.dataNotAllowed)))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}
