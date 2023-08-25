//
//  RMLaunchScreenView.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 25.08.2023.
//

import UIKit

class RMLaunchScreenView: UIView {
    
    private let rickAndMortyLogo : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rick_and_morty_logo")
        imageView.alpha = 0
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private(set) var launchLabel : UILabel = {
        let launchLabel = UILabel()
        launchLabel.textColor = .label
        launchLabel.alpha = 0
        launchLabel.textAlignment = .center
        launchLabel.font = .systemFont(ofSize: 40, weight: .bold)
        launchLabel.translatesAutoresizingMaskIntoConstraints = false
        return launchLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setUpConstraints()
        UIView.animate(withDuration: 2) {
            self.rickAndMortyLogo.alpha = 1
            self.launchLabel.alpha = 1
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        
        addSubViews(rickAndMortyLogo,launchLabel)
        
        NSLayoutConstraint.activate([
        
            rickAndMortyLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
            rickAndMortyLogo.centerYAnchor.constraint(equalTo: centerYAnchor),
            rickAndMortyLogo.heightAnchor.constraint(equalToConstant: 150),
            rickAndMortyLogo.widthAnchor.constraint(equalToConstant: 350),
            
            launchLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            launchLabel.topAnchor.constraint(equalTo: rickAndMortyLogo.bottomAnchor, constant: 20),
            launchLabel.heightAnchor.constraint(equalToConstant: 100),
            launchLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            launchLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),

        
        
        ])
    }

}
