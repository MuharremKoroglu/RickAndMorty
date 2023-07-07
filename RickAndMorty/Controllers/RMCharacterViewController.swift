//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 10.06.2023.
//

import UIKit

class RMCharacterViewController: UIViewController, LocationViewDelegate {
    
    private let characterView = RMCharacterView()
    private let locationView = RMLocationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpViews()
        locationView.delegate = self
    }
    
    private func setUpViews () {
        view.addSubViews(characterView,locationView)
        NSLayoutConstraint.activate([
            
            locationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            locationView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            locationView.heightAnchor.constraint(equalToConstant: 70),

            characterView.topAnchor.constraint(equalTo: locationView.bottomAnchor),
            characterView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func didSelectLocation(with parsedCharacterIDs: [String]) {
        characterView.handleParsedCharacterIDs(parsedCharacterIDs)
    }
}
