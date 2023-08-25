//
//  RMLocationViewModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 11.06.2023.
//

import UIKit
import Foundation

protocol LocationViewModelDelegate : AnyObject {
    func didLoadLocations ()
}

class LocationViewModel {

    weak var delegate : LocationViewModelDelegate?
    private let service : RMApiCallService
    var locationNameArray : [LocationNameAndResidents] = []
    var locationInfo : LocationInfo? = nil
    var isLoadMoreLocation = false
    var areThereMoreLocationIndicator : Bool {
        return locationInfo?.next != nil
    }
    
    init(service: RMApiCallService) {
        self.service = service
    }
    
    func fetchLocationName (request : RMRequest) {
        service.executeApiCall(request: request, dataType: Locations.self) { [weak self] result in
            switch result {
            case .success(let model):
                let results = model.results
                let info = model.info
                self?.locationInfo = info
                
                DispatchQueue.main.async {
                    self?.locationNameArray = results.map(LocationNameAndResidents.init)
                    self?.delegate?.didLoadLocations()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
 
    func fetchMoreLocation (url : URL) {
        guard !isLoadMoreLocation else {
            return
        }
        isLoadMoreLocation = true
        if let page = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.first(where: { $0.name == "page" })?.value {
            let rmRequest = RMRequest(endPoints: .location, query: [URLQueryItem(name: "page", value: page)])
            service.executeApiCall(request: rmRequest, dataType: Locations.self) { [ weak self ] result in
                guard let strongSelf = self else {
                    return
                }
                switch result {
                case .success(let model):
                    let results = model.results
                    let mappedResults = results.map(LocationNameAndResidents.init)
                    
                    let info = model.info
                    strongSelf.locationInfo = info
                    
                    DispatchQueue.main.async {
                        strongSelf.locationNameArray.append(contentsOf: mappedResults)
                        strongSelf.delegate?.didLoadLocations()
                        strongSelf.isLoadMoreLocation = false
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    strongSelf.isLoadMoreLocation = false
                }
            }
        }

    }
}


