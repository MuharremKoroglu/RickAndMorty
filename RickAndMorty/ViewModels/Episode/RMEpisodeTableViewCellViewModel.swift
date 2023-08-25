//
//  RMEpisodeTableViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 27.07.2023.
//

import Foundation

struct EpisodeInfo : RMCharacterDetailViewEpisodesRendering {
    
    var episodes : EpisodesResult
    
    var episodeName : String {
        return episodes.name
    }
    
    var episodeAirDate : String {
        return episodes.date
    }
    
    var episodeInfo : String {
        return episodes.episode
    }
    
    var episodeCreated : String {
        return episodes.created
    }
    
    var episodeCharacter : [String] {
        return episodes.characters
    }
    
}
