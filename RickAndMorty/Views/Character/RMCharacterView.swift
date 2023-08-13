//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 11.06.2023.
//

import UIKit

protocol RMCharacterViewDelegate : AnyObject {
    func selectedCharacter (
        _ characterView : RMCharacterView,
        character : Character)
}

class RMCharacterView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CharacterViewModelDelegate {
    
    weak var delegate : RMCharacterViewDelegate?
    private var selectedCharacters : [Character] = []
    private var characterIDs : [String] = []
    private let characterViewModel : CharacterViewModel
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
        collectionView.isHidden = true
        collectionView.alpha = 0
        return collectionView
    }()
    
    private let noCharacterLabel : UILabel = {
        let noCharacterLabel = UILabel()
        noCharacterLabel.text = "No characters found at this location!"
        noCharacterLabel.textAlignment = .center
        noCharacterLabel.textColor = .label
        noCharacterLabel.font = .systemFont(ofSize: 15, weight: .bold)
        noCharacterLabel.translatesAutoresizingMaskIntoConstraints = false
        return noCharacterLabel
    }()
    
    init(frame: CGRect,characterViewModel : CharacterViewModel) {
        self.characterViewModel = characterViewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setUpCollectionView()
        addConstraint()
        spinner.startAnimating()
        noCharacterLabel.isHidden = false
        characterViewModel.delegate = self

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didLoadInitialCharacter() {
        spinner.stopAnimating()
        spinner.isHidden = true
        noCharacterLabel.isHidden = true
        collectionView.isHidden = false
        collectionView.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    func didSelectedCharacter(with character: [Character]) {
        self.selectedCharacters = character
    }
    
    private func addConstraint() {
        addSubViews(spinner,collectionView,noCharacterLabel)
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            noCharacterLabel.widthAnchor.constraint(equalToConstant: 300),
            noCharacterLabel.heightAnchor.constraint(equalToConstant: 20),
            noCharacterLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor,constant: 10),
            noCharacterLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setUpCollectionView () {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func handleParsedCharacterIDs(_ parsedCharacterIDs: [String]) {
        characterIDs = parsedCharacterIDs
        if characterIDs.isEmpty == true {
            self.collectionView.isHidden = true
            self.spinner.isHidden = false
            self.noCharacterLabel.isHidden = false
            self.spinner.startAnimating()
        }else{
            characterViewModel.fetchCharacterData(request: RMRequest(endPoints: .character,path: characterIDs))
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterViewModel.cellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? RMCharacterCollectionViewCell else {
            fatalError("This cell not supported!")
        }
        cell.configure(with: characterViewModel.cellViewModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        let height = width * 1.5
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = selectedCharacters[indexPath.row]
        self.delegate?.selectedCharacter(self, character: character)
    }
    
}


