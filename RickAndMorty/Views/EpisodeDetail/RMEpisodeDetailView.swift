//
//  RMEpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 28.07.2023.
//

import UIKit

protocol RMEpisodeDetailViewDelegate : AnyObject {
    func selectedCharacter (
        _ detailView : RMEpisodeDetailView,
        selectedCaharacter : Character
    )
}

class RMEpisodeDetailView : UIView, UICollectionViewDelegate, UICollectionViewDataSource, RMEpisodeDetailViewViewModelDelegate {
    
    weak var delegate : RMEpisodeDetailViewDelegate?
    private let viewModel : RMEpisodeDetailViewViewModel
    private var collectionView : UICollectionView?
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    init(frame: CGRect, viewModel : RMEpisodeDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        spinner.startAnimating()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        viewModel.delegate = self
        setUpConstraints()
        setUpCollectionView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchedRelatedCharacters() {
        spinner.stopAnimating()
        spinner.isHidden = true
        collectionView?.reloadData()
        collectionView?.isHidden = false
       
        
        UIView.animate(withDuration: 0.4) {
            self.collectionView?.alpha = 1
        }
    }
    
    private func setUpCollectionView () {
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    private func setUpConstraints() {
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
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.register(
            RMEpisodeDetailViewInfoCollectionViewCell.self,
            forCellWithReuseIdentifier: RMEpisodeDetailViewInfoCollectionViewCell.cellIdentifier
        )
        collectionView.register(
            RMCharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }
    
    private func createSection (for sectionIndex : Int) -> NSCollectionLayoutSection {

        let sectionTypes = viewModel.sections
        switch sectionTypes[sectionIndex] {
        case .characters:
            return viewModel.createCharacterSectionLayout()
        case .information:
            return viewModel.createInfoSectionLayout()

        }

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = viewModel.sections[section]
        
        switch section {
        case .characters(let viewModel):
            return viewModel.count
        case .information(let viewModel):
            return viewModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
        case .characters(let viewModels):
            let viewModel = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? RMCharacterCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell

        case .information (let viewModels):
            let viewModel = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMEpisodeDetailViewInfoCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as? RMEpisodeDetailViewInfoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell

        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
        case .characters:
            guard let character = viewModel.character(at : indexPath.row) else {
                return 
            }
            self.delegate?.selectedCharacter(self, selectedCaharacter: character)
        case .information:
            break

        }
    }

}
