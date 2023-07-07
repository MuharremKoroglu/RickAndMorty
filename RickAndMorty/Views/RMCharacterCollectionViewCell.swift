//
//  RMCharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 23.06.2023.
//

import UIKit

class RMCharacterCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
    private var characterGender : String?
    
    private let characterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let characterNameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .label
        nameLabel.font = .systemFont(ofSize: 16, weight: .heavy)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private let characterStatusLabel : UILabel = {
        let statusLabel = UILabel()
        statusLabel.textColor = .secondaryLabel
        statusLabel.font = .systemFont(ofSize: 15, weight: .regular)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpBorderColorForGenderType () {
        let maleColor : CGColor = UIColor.systemBlue.cgColor
        let femaleColor : CGColor = UIColor.systemPurple.cgColor
        let unknownColor : CGColor = UIColor.systemRed.cgColor
        
        contentView.layer.borderColor = self.characterGender == "Male" ? maleColor : (self.characterGender == "Female" ? femaleColor : unknownColor)
    
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 3
        
    }
    
    private func setUpConstraints () {
        contentView.addSubViews(characterImageView,characterNameLabel,characterStatusLabel)
        NSLayoutConstraint.activate([
            
            characterStatusLabel.heightAnchor.constraint(equalToConstant: 30),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            characterStatusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            characterNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            characterStatusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            characterNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            
            characterStatusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            characterNameLabel.bottomAnchor.constraint(equalTo: characterStatusLabel.topAnchor),
            
            
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            characterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            characterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            characterImageView.bottomAnchor.constraint(equalTo: characterNameLabel.topAnchor, constant: -3),
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
        characterNameLabel.text = nil
        characterStatusLabel.text = nil
        characterGender = nil
    }
    
    public func configure (with viewModel : RMCharacterCollectionViewCellViewModel) {
        self.characterNameLabel.text = viewModel.characterName
        self.characterStatusLabel.text = viewModel.characterStatusText
        self.characterGender = viewModel.characterGenderText
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.characterImageView.image = image
                    self?.setUpBorderColorForGenderType()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}
