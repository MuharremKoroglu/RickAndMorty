//
//  RMCharacterDetailViewPhotoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 20.07.2023.
//

import Foundation

class RMCharacterDetailViewPhotoCollectionViewCellViewModel {
    
    let characterPhotoUrl : URL?
    
    init(characterPhotoUrl: URL?) {
        self.characterPhotoUrl = characterPhotoUrl
    }
    
    func fetchCharacterImage (completion : @escaping(Result<Data,Error>) -> Void) {
        
        guard let imageURL = characterPhotoUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        RMImageDownloader.shared.downloadImage(imageURL, completion: completion)
    }
    
}
