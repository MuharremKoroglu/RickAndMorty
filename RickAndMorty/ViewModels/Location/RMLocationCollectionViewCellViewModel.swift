//
//  RMLocationCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 27.07.2023.
//

import Foundation

struct LocationName {
    
    var location : LocationResult
    
    var name : String {
        location.name
    }
    
    var residents : [String] {
        location.residents
    }

}
