//
//  RMCharacterDetailViewInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 20.07.2023.
//

import UIKit

class RMCharacterDetailViewInfoCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMCharacterDetailViewInfoCollectionViewCell"
    
    private let sectionTitleLabel : UILabel = {
        let sectionTitleLabel = UILabel()
        sectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionTitleLabel.textAlignment = .center
        sectionTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        return sectionTitleLabel
    }()
    
    private let sectionContentLabel : UILabel = {
        let sectionContentLabel = UILabel()
        sectionContentLabel.numberOfLines = 0
        sectionContentLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionContentLabel.font = .systemFont(ofSize: 22, weight: .light)
        return sectionContentLabel
    }()
    
    private let sectionIconImage : UIImageView = {
        let sectionIconImage = UIImageView()
        sectionIconImage.translatesAutoresizingMaskIntoConstraints = false
        sectionIconImage.image = UIImage(systemName: "globe")
        sectionIconImage.contentMode = .scaleAspectFit
        return sectionIconImage
    }()
    
    private let sectionTitleContainerView : UIView = {
        let sectionTitleContainerView = UIView()
        sectionTitleContainerView.translatesAutoresizingMaskIntoConstraints = false
        sectionTitleContainerView.backgroundColor = .secondarySystemBackground
        return sectionTitleContainerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sectionTitleLabel.text = nil
        sectionContentLabel.text = nil
        sectionIconImage.image = nil
        sectionTitleLabel.textColor = .label
        sectionContentLabel.textColor = .label
    }
    
    private func setUpConstraints () {
        contentView.addSubViews(sectionTitleContainerView,sectionTitleLabel,sectionContentLabel,sectionIconImage)
        sectionTitleContainerView.addSubview(sectionTitleLabel)
        
        NSLayoutConstraint.activate([
        
            sectionTitleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            sectionTitleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            sectionTitleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            sectionTitleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.30),
            
            sectionTitleLabel.topAnchor.constraint(equalTo: sectionTitleContainerView.topAnchor),
            sectionTitleLabel.leftAnchor.constraint(equalTo: sectionTitleContainerView.leftAnchor),
            sectionTitleLabel.rightAnchor.constraint(equalTo: sectionTitleContainerView.rightAnchor),
            sectionTitleLabel.bottomAnchor.constraint(equalTo: sectionTitleContainerView.bottomAnchor),
            
            sectionIconImage.heightAnchor.constraint(equalToConstant: 25),
            sectionIconImage.widthAnchor.constraint(equalToConstant: 25),
            sectionIconImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            sectionIconImage.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10),
            
            sectionContentLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            sectionContentLabel.leftAnchor.constraint(equalTo: sectionIconImage.rightAnchor,constant: 10),
            sectionContentLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10),
            sectionContentLabel.bottomAnchor.constraint(equalTo: sectionTitleContainerView.topAnchor)

        ])
    }

    func configure (with viewModel : RMCharacterDetailViewInfoCollectionViewCellViewModel) {
        sectionTitleLabel.text = viewModel.sectionTitle
        sectionContentLabel.text = viewModel.displayContent
        sectionIconImage.image = viewModel.contentIcon
        sectionIconImage.tintColor = viewModel.sectionColor
        sectionTitleLabel.textColor = viewModel.sectionColor
    }

}
