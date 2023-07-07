//
//  RMCharacterViewModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 11.06.2023.
//

import UIKit

protocol CharacterViewModelDelegate : AnyObject {
    func didLoadInitialCharacter ()
}

class CharacterViewModel {
    
    weak var delegate : CharacterViewModelDelegate?
    var cellViewModel : [RMCharacterCollectionViewCellViewModel] = []
    private let service = RMApiCall()
    
    func fetchCharacterData (request : RMRequest) {
        service.executeApiCall(request: request, dataType: [Characters].self) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let model):
                DispatchQueue.main.async {
                    self?.cellViewModel.removeAll()
                    for character in model {
                        let viewModel = RMCharacterCollectionViewCellViewModel(characterName: character.name, characterStatus: character.status, characterGender: character.gender, characterImage: URL(string: character.image))
                        self?.cellViewModel.append(viewModel)
                        self?.delegate?.didLoadInitialCharacter()
                    }
                    
                }
            }
        }
    }
}




