//
//  RMCharacterDetailViewPhotoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 20.07.2023.
//

import UIKit

class RMCharacterDetailViewPhotoCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMCharacterDetailViewPhotoCollectionViewCell"
    
    private let characterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
    }
    
    private func setUpConstraints () {
        
        contentView.addSubViews(characterImageView)
        
        NSLayoutConstraint.activate([
        
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            characterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    
    }

    func configure (with viewModel : RMCharacterDetailViewPhotoCollectionViewCellViewModel) {
        
        viewModel.fetchCharacterImage { [ weak self ]result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.characterImageView.image = UIImage(data: data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
