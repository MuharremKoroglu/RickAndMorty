//
//  RMCharacterViewModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 11.06.2023.
//

import UIKit

protocol CharacterViewModelDelegate : AnyObject {
    func didLoadInitialCharacter ()
    func didSelectedCharacter (with character : [Character])
}

class CharacterViewModel {
    
    weak var delegate : CharacterViewModelDelegate?
    var characters : [Character] = []
    var cellViewModel : [RMCharacterCollectionViewCellViewModel] = []
    private let service = RMApiCall()
    
    func fetchCharacterData (request : RMRequest) {
        service.executeApiCall(request: request, dataType: [Character].self) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let model):
                DispatchQueue.main.async {
                    self?.cellViewModel.removeAll()
                    self?.characters.removeAll()
                    for character in model {
                        let viewModel = RMCharacterCollectionViewCellViewModel(characterName: character.name, characterStatus: character.status, characterGender: character.gender, characterImage: URL(string: character.image))
                        self?.cellViewModel.append(viewModel)
                        self?.characters.append(character)
                        self?.delegate?.didLoadInitialCharacter()
                        self?.delegate?.didSelectedCharacter(with: self!.characters)
                    }
                    
                }
            }
        }
    }
}




