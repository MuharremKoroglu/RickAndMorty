//
//  RMEpisodeDetailViewInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 3.08.2023.
//

import UIKit

class RMEpisodeDetailViewInfoCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMEpisodeDetailViewInfoCollectionViewCell"
    
    private let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let valueLabel : UILabel = {
        let valueLabel = UILabel()
        valueLabel.font = .systemFont(ofSize: 20, weight: .regular)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.textAlignment = .right
        valueLabel.numberOfLines = 0
        return valueLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        configureLayout()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    private func setUpConstraints () {
        contentView.addSubViews(titleLabel,valueLabel)
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
        
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.47),
            valueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.47),

        ])
    }
    
    private func configureLayout () {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.masksToBounds = true
        layer.borderColor = UIColor.secondaryLabel.cgColor
        
    }
    
    func configure (with viewModel : RMEpisodeDetailViewInfoCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
    
}
