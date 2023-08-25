//
//  RMCharacterDetailViewEpisodesCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 17.08.2023.
//

import Foundation

protocol RMCharacterDetailViewEpisodesRendering {
    var episodeName : String {get}
    var episodeInfo : String {get}
    var episodeAirDate : String {get}
}

class RMCharacterDetailViewEpisodesCollectionViewCellViewModel {
    
    var characterEpisodes: [EpisodeInfo] = []
    private var parsedEpisodeIDs: [String] = []
    private var episodeURL: URL?
    private let service: RMApiCallService
    private var dataBlock: ((RMCharacterDetailViewEpisodesRendering) -> Void)?
    private var isFetching = false
    
    init(episodeURL: URL?, service: RMApiCallService) {
        self.episodeURL = episodeURL
        self.service = service
        episodeIDParser()
    }
    
    func registerData(_ block: @escaping (RMCharacterDetailViewEpisodesRendering) -> Void) {
        self.dataBlock = block
    }
    
    private func episodeIDParser() {
        guard let lastPathComponent = episodeURL?.lastPathComponent else {
            return
        }
        self.parsedEpisodeIDs.append(lastPathComponent)
    }
    
    func fetchEpisodeData() {
        guard !isFetching else {
            if let model = self.characterEpisodes.last {
                dataBlock?(model)
            }
            return
        }
        
        let request = RMRequest(endPoints: .episode, path: parsedEpisodeIDs)
        
        isFetching = true
        
        service.executeApiCall(request: request, dataType: [EpisodesResult].self) { [weak self] result in
            
            switch result {
            case .success(let model):
                self?.characterEpisodes = model.map(EpisodeInfo.init)
                
                if let singleEpisodeInfo = self?.characterEpisodes.last {
                    DispatchQueue.main.async {
                        self?.dataBlock?(singleEpisodeInfo)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            self?.isFetching = false
        }
    }
}
