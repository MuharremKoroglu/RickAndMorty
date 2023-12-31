//
//  RMCharacterViewViewModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 10.07.2023.
//

import UIKit

class RMCharacterDetailViewViewModel {
    
    private let character : Character
    
    var title : String {
        character.name.uppercased()
    }
    
    var episodes : [String] {
        character.episode
    }
    
    var sections : [SectionType] = []
    
    enum SectionType {
        case characterImage(viewModel : RMCharacterDetailViewPhotoCollectionViewCellViewModel)
        case characterInfo(viewModels : [RMCharacterDetailViewInfoCollectionViewCellViewModel])
        case characterEpisodes(viewModels : [RMCharacterDetailViewEpisodesCollectionViewCellViewModel])
    }
    
    init(character : Character) {
        self.character = character
        setUpSections()
    }
    


    
    private func setUpSections () {
        sections = [
            .characterImage(viewModel:
                    .init(characterPhotoUrl: URL(string: character.image))
            ),
            .characterInfo(viewModels: [
                .init(sectionContent: character.status.text, contentType: .status),
                .init(sectionContent: character.species, contentType: .species),
                .init(sectionContent: character.type,contentType: .type),
                .init(sectionContent: character.gender.genderText,contentType: .gender),
                .init(sectionContent: character.origin.name.capitalized,contentType: .origin),
                .init(sectionContent: character.location.name,contentType: .location),
                .init(sectionContent: "\(character.episode.count)",contentType: .episodeCount),
                .init(sectionContent: character.created,contentType: .created)
            ]),
            
            .characterEpisodes(viewModels: character.episode.compactMap({
                return RMCharacterDetailViewEpisodesCollectionViewCellViewModel(episodeURL: URL(string: $0), service: RMApiCall())
            }))
        ]
    }
    
    func createCharacterImageSection () -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
    
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 3,
            leading: 5,
            bottom: 3,
            trailing: 5
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createCharacterInfoSection () -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 3,
            leading: 3,
            bottom: 3,
            trailing: 3
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(150)
            ),
            subitems: [item , item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createCharacterEpisodesSection () -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 3,
            bottom: 3,
            trailing: 3
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
            heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

    
}
