//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 10.06.2023.
//

import UIKit

class RMCharacterViewController: UIViewController {
    
    private let characterView = CharacterView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        setUpViews()

    }
    
    private func setUpViews () {
        view.addSubview(characterView)
        NSLayoutConstraint.activate([
            characterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
