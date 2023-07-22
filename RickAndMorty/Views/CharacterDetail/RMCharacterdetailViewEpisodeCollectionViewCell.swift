//
//  RMCharacterdetailViewEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 20.07.2023.
//

import UIKit

class RMCharacterdetailViewEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterdetailViewEpisodeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setUpConstraints () {
        
    }

    func configure (with viewModel : RMCharacterdetailViewEpisodeCollectionViewCellViewModel) {
        
    }

}
