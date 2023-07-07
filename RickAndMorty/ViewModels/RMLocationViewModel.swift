//
//  RMLocationViewModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 11.06.2023.
//

import Foundation

protocol LocationViewModelDelegate : AnyObject {
    func didLoadLocations ()
}

class LocationViewModel {
    
    weak var delegate : LocationViewModelDelegate?
    var locationNameArray : [LocationName] = []
    private let service = RMApiCall()
    
    func fetchLocationName (request : RMRequest) {
        service.executeApiCall(request: request, dataType: Locations.self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.locationNameArray = model.results.map(LocationName.init)
                    self?.delegate?.didLoadLocations()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
 
}

struct LocationName {
    
    var location : LocationResult
    
    var name : String {
        location.name
    }
    
    var residents : [String] {
        location.residents
    }

}
