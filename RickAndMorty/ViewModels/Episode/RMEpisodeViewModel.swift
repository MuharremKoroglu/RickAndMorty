//
//  RMEpisodeViewModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 11.06.2023.
//

import Foundation

protocol RMEpisodeViewModelDelegate : AnyObject {
    func didLoadEpisode ()
}

class RMEpisodeViewModel {
    
    weak var delegate : RMEpisodeViewModelDelegate?
    var episodes : [EpisodeInfo] = []
    private let service : RMApiCallService
    var episodeInfo : EpisodesInfo? = nil
    var isLoadMoreEpisode = false
    var areThereMoreEpisodeIndicator : Bool {
        return episodeInfo?.next != nil
    }
    
    init(service: RMApiCallService) {
        self.service = service
    }
    
    func fetchEpisodes (request : RMRequest) {
        
        service.executeApiCall(request: request, dataType: Episodes.self) { [ weak self ] result in
            switch result {
            case .success(let model):
                let results = model.results
                let info = model.info
                self?.episodeInfo = info
                DispatchQueue.main.async {
                    self?.episodes = results.map(EpisodeInfo.init)
                    self?.delegate?.didLoadEpisode()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
    
    func fetchMoreEpisode () {
        guard !isLoadMoreEpisode else {
            return
        }
        
        guard let nextUrl = episodeInfo?.next,
              let url = URL(string: nextUrl) else {
            return
        }
        
        isLoadMoreEpisode = true
        
        if let page = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.first(where: { $0.name == "page" })?.value {
            let rmRequest = RMRequest(endPoints: .episode, query: [URLQueryItem(name: "page", value: page)])
            service.executeApiCall(request: rmRequest, dataType: Episodes.self) { [ weak self ] result in
                guard let strongSelf = self else {
                    return
                }
                switch result {
                case .success(let model):
                    let results = model.results
                    let mappedResults = results.map(EpisodeInfo.init)
                    
                    let info = model.info
                    strongSelf.episodeInfo = info
                    
                    DispatchQueue.main.async {
                        strongSelf.episodes.append(contentsOf: mappedResults)
                        strongSelf.delegate?.didLoadEpisode()
                        strongSelf.isLoadMoreEpisode = false
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    strongSelf.isLoadMoreEpisode = false
                }
            }
        }

    }
    

}
