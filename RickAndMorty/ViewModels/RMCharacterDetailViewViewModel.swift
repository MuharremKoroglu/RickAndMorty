//
//  RMCharacterViewViewModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 10.07.2023.
//

import Foundation

class RMCharacterDetailViewViewModel {
    
    private let character : Character
    
    init(character : Character) {
        self.character = character
    }
    
    var title : String {
        character.name.uppercased()
    }
    
}
