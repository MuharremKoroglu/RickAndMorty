//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 10.06.2023.
//

import UIKit

class RMCharacterViewController: UIViewController, LocationViewDelegate, RMCharacterViewDelegate {

    private let characterView = RMCharacterView(frame: .zero, characterViewModel: CharacterViewModel(service: RMApiCall()))
    private let locationView = RMLocationView(frame: .zero, viewModel: LocationViewModel(service: RMApiCall()))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpViews()
    }
    
    private func setUpViews () {
        locationView.delegate = self
        characterView.delegate = self
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

    func selectedCharacter(_ characterView: RMCharacterView, character: Character) {
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
