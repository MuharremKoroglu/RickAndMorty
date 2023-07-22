//
//  RMCharacterDetailView.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 10.07.2023.
//

import UIKit

class RMCharacterDetailView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var collectionView : UICollectionView?
    private var viewModel : RMCharacterDetailViewViewModel

    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    init(frame: CGRect, viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        setUpConstraints()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCollectionView () {
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    private func setUpConstraints () {
    
        guard let collectionView = collectionView else {
            return
        }
        
        addSubViews(spinner,collectionView)
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
    }
    
    private func createCollectionView () -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for : sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            RMCharacterDetailViewPhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: RMCharacterDetailViewPhotoCollectionViewCell.cellIdentifier
        )
        collectionView.register(
            RMCharacterDetailViewInfoCollectionViewCell.self,
            forCellWithReuseIdentifier: RMCharacterDetailViewInfoCollectionViewCell.cellIdentifier
        )
        collectionView.register(
            RMCharacterdetailViewEpisodeCollectionViewCell.self,
            forCellWithReuseIdentifier: RMCharacterdetailViewEpisodeCollectionViewCell.cellIdentifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }
    
    private func createSection (for sectionIndex : Int) -> NSCollectionLayoutSection {
        
        let sectionTypes = viewModel.sections
        switch sectionTypes[sectionIndex] {
        case .characterImage:
            return viewModel.createCharacterImageSection()
        case.characterInfo:
            return viewModel.createCharacterInfoSection()

        }

    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        
        switch sectionType {
        case .characterImage:
            return 1
        case .characterInfo(let viewModels):
            return viewModels.count

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
        case .characterImage(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterDetailViewPhotoCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? RMCharacterDetailViewPhotoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell

        case .characterInfo(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterDetailViewInfoCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? RMCharacterDetailViewInfoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell

        }
       
    }

}
