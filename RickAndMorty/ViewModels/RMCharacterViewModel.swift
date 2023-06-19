//
//  RMCharacterViewModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 11.06.2023.
//

import UIKit

class CharacterViewModel {
    
    var allcharacters : [AllCharacters] = []
    private let service = RMApiCall()
    
    func fetchCharacterdata (request : RMRequest) {
        
        service.executeApiCall(request: request, dataType: AllCharacters.self) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let characters):
                DispatchQueue.main.async {
                    self.allcharacters.append(characters)
                }
            }
        }
    }
}




