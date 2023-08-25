//
//  RMCharacterDetailViewEpisodesCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 17.08.2023.
//

import UIKit

class RMCharacterDetailViewEpisodesCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier = "RMCharacterDetailViewEpisodesCollectionViewCell"
    
    private var episodeNameLabel : UILabel = {
        let episodeNameLabel = UILabel()
        episodeNameLabel.textColor = .label
        episodeNameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        episodeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return episodeNameLabel
    }()
    
    private var episodeNumberLabel : UILabel = {
        let episodeNumberLabel = UILabel()
        episodeNumberLabel.textColor = .label
        episodeNumberLabel.font = .systemFont(ofSize: 22, weight: .regular)
        episodeNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        return episodeNumberLabel
    }()
    
    private var episodeAirDateLabel : UILabel = {
        let episodeAirDateLabel = UILabel()
        episodeAirDateLabel.textColor = .label
        episodeAirDateLabel.font = .systemFont(ofSize: 18, weight: .light)
        episodeAirDateLabel.translatesAutoresizingMaskIntoConstraints = false
        return episodeAirDateLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemGreen.cgColor
        setUpConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.episodeNameLabel.text = nil
        self.episodeNumberLabel.text = nil
        self.episodeAirDateLabel.text = nil
        
    }
    
    private func setUpConstraints () {
        contentView.addSubViews(episodeNameLabel, episodeNumberLabel,episodeAirDateLabel)
        
        NSLayoutConstraint.activate([
        
            episodeNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            episodeNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10),
            episodeNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10),
            episodeNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.3),
            
            episodeNumberLabel.topAnchor.constraint(equalTo: episodeNameLabel.bottomAnchor),
            episodeNumberLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10),
            episodeNumberLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10),
            episodeNumberLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.3),
            
            episodeAirDateLabel.topAnchor.constraint(equalTo: episodeNumberLabel.bottomAnchor),
            episodeAirDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10),
            episodeAirDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10),
            episodeAirDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.3),

        
        ])
        
    }

    func configure (with viewModel : RMCharacterDetailViewEpisodesCollectionViewCellViewModel) {
        viewModel.registerData { data in
            self.episodeNameLabel.text = data.episodeName
            self.episodeNumberLabel.text = "Episode " + data.episodeInfo
            self.episodeAirDateLabel.text = "Aired on " + data.episodeAirDate
        }
        viewModel.fetchEpisodeData()

    }
}
