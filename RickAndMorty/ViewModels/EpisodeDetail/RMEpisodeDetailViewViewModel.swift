//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 3.08.2023.
//

import UIKit

protocol RMEpisodeDetailViewViewModelDelegate : AnyObject {
    func fetchedRelatedCharacters ()
}

class RMEpisodeDetailViewViewModel {
    
    weak var delegate : RMEpisodeDetailViewViewModelDelegate?
    private let episode : EpisodeInfo
    private let service : RMApiCallService
    var sections : [SectionType] = []
    private var parsedCharacterID : [String] = []
    private var characters : [Character] = []
    
    enum SectionType {
        case information(viewModels : [RMEpisodeDetailViewInfoCollectionViewCellViewModel])
        case characters (viewModel : [RMCharacterCollectionViewCellViewModel])
        
    }

    
    init(episode: EpisodeInfo,service : RMApiCallService) {
        self.episode = episode
        self.service = service
        getReleatedCharacters()
    }
    
    
    private func getReleatedCharacters () {
        let characters = episode.episodeCharacter
        self.parsedCharacterID.removeAll()
        for characterUrl in characters {
            if let url = URL(string: characterUrl) {
                let characterID = url.lastPathComponent
                self.parsedCharacterID.append(characterID)
            }
        }
        let request = RMRequest(endPoints: .character,path: parsedCharacterID)
        service.executeApiCall(request: request, dataType: [Character].self) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                DispatchQueue.main.async {
                    self?.setUpSections()
                    self?.delegate?.fetchedRelatedCharacters()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    private func setUpSections () {
        
        var createdDate : String {
            return RMDateFormatter.shared.formattedDate(with: episode.episodeCreated)
        }
    
        sections = [
            .information(viewModels: [
                
                .init(title: "Episode Name", value: episode.episodeName),
                .init(title: "Episode", value: episode.episodeInfo),
                .init(title: "Air Date", value: episode.episodeAirDate),
                .init(title: "Created", value: createdDate),
                
            ]),
            
            .characters(viewModel: characters.compactMap({ character in
                return RMCharacterCollectionViewCellViewModel(
                    characterName: character.name.capitalized,
                    characterStatus: character.status,
                    characterGender: character.gender,
                    characterImage: URL(string: character.image)
                    
                )
                
                
            }))
        ]
    }
    
    func character (at index : Int) -> Character? {
        return characters[index]
    }

    
    func createInfoSectionLayout () ->NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(90)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createCharacterSectionLayout () ->NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 10,
            bottom: 5,
            trailing: 10
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(250)
            ),
            subitems: [item , item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    

}
