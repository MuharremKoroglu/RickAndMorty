//
//  RMEpisodeTableViewCell.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 27.07.2023.
//

import UIKit

class RMEpisodeTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "RMEpisodeTableViewCell"
    
    private var episodeName : UILabel = {
        let episodeName = UILabel()
        episodeName.textColor = .label
        episodeName.numberOfLines = 0
        episodeName.font = .systemFont(ofSize: 22, weight: .bold)
        episodeName.translatesAutoresizingMaskIntoConstraints = false
        return episodeName
    }()
    
    private var episodeInfo : UILabel = {
        let episodeInfo = UILabel()
        episodeInfo.textColor = .secondaryLabel
        episodeInfo.font = .systemFont(ofSize: 17, weight: .medium)
        episodeInfo.translatesAutoresizingMaskIntoConstraints = false
        return episodeInfo
    }()
    
    private var episodeAirDate : UILabel = {
        let episodeAirDate = UILabel()
        episodeAirDate.textColor = .secondaryLabel
        episodeAirDate.font = .systemFont(ofSize: 15, weight: .light)
        episodeAirDate.translatesAutoresizingMaskIntoConstraints = false
        return episodeAirDate
    }()
    
    
    private var episodeCharacterCount : UILabel = {
        let episodeCharacterCount = UILabel()
        episodeCharacterCount.textColor = .secondaryLabel
        episodeCharacterCount.font = .systemFont(ofSize: 15, weight: .light)
        episodeCharacterCount.translatesAutoresizingMaskIntoConstraints = false
        return episodeCharacterCount
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        episodeName.text = nil
        episodeInfo.text = nil
        episodeAirDate.text = nil
        episodeCharacterCount.text = nil
    }
    
    private func setUpConstraints() {
        
        contentView.addSubViews(episodeName,episodeAirDate,episodeInfo,episodeCharacterCount)
        
        NSLayoutConstraint.activate([
            
            episodeName.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            episodeName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            episodeName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            
            episodeInfo.topAnchor.constraint(equalTo: episodeName.bottomAnchor,constant: 10),
            episodeInfo.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            episodeInfo.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            
            episodeAirDate.topAnchor.constraint(equalTo:episodeInfo.bottomAnchor ,constant: 10),
            episodeAirDate.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            episodeAirDate.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            
            episodeCharacterCount.topAnchor.constraint(equalTo: episodeAirDate.bottomAnchor,constant: 10),
            episodeCharacterCount.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            episodeCharacterCount.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            episodeCharacterCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        
        
        ])
        
        
    }
    

    public func configure (with viewModel : EpisodeInfo) {
        episodeName.text = viewModel.episodeName
        episodeAirDate.text = "Air Date : " + viewModel.episodeAirDate
        episodeInfo.text = "Episode : " + viewModel.episodeInfo
        episodeCharacterCount.text = "Character Count : \(viewModel.episodeCharacter.count)"
        
    }
    
}
