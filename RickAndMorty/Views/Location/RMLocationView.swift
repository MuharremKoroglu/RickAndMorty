//
//  LocationView.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 19.06.2023.
//

import Foundation
import UIKit

protocol LocationViewDelegate: AnyObject {
    func didSelectLocation(with parsedCharacterIDs: [String])
}

class RMLocationView : UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate, LocationViewModelDelegate{

    weak var delegate: LocationViewDelegate?
    private let viewModel : LocationViewModel
    private var parsedCharacterIDs : [String] = []
    private var selected : String = "Earth (C-137)"
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMLocationCollectionViewCell.self, forCellWithReuseIdentifier: RMLocationCollectionViewCell.cellIndetifier)
        collectionView.register(RMLocationLoaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMLocationLoaderCollectionReusableView.identifier)
        collectionView.isHidden = true
        collectionView.alpha = 0
        return collectionView
    }()

    init(frame: CGRect, viewModel : LocationViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setUpCollectionView()
        addConstraint()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchLocationName(request: RMRequest(endPoints: .location))
        
        if let firstLocation = viewModel.locationNameArray.first {
            selected = firstLocation.name
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didLoadLocations() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
        
        if let index = viewModel.locationNameArray.firstIndex(where: {$0.name == selected}) {
            clickForParseCharacterID(IndexPath(row: index, section: 0))
        }
    }
    
    private func addConstraint() {
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
    
    private func setUpCollectionView () {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.locationNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMLocationCollectionViewCell.cellIndetifier,
            for: indexPath
        ) as? RMLocationCollectionViewCell else {
            fatalError("This cell not supported!")
        }
        cell.configure(with: viewModel.locationNameArray[indexPath.row])
        cell.layer.cornerRadius = 20
        if viewModel.locationNameArray[indexPath.row].name == selected {
            cell.layer.borderColor = UIColor.systemGreen.cgColor
            cell.layer.borderWidth = 4
         } else {
             cell.layer.borderWidth = 0
         }
        
        return cell
    }
    
    func clickForParseCharacterID (_ indexpath : IndexPath) {
        selected = viewModel.locationNameArray[indexpath.row].name
        let location = viewModel.locationNameArray[indexpath.row]
        self.parsedCharacterIDs.removeAll()
        for resident in location.residents {
            if let url = URL(string: resident) {
                let characterID = url.lastPathComponent
                self.parsedCharacterIDs.append(characterID)
            }
        }
        delegate?.didSelectLocation(with: parsedCharacterIDs)
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickForParseCharacterID(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        let height = width * 0.25
        
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard viewModel.areThereMoreLocationIndicator,
              !viewModel.isLoadMoreLocation,
              !viewModel.locationNameArray.isEmpty,
              let nextUrl = viewModel.locationInfo?.next,
              let url = URL(string: nextUrl)  else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [ weak self ] timer in
            let offset = scrollView.contentOffset.x
            let totalContentWidth = scrollView.contentSize.width
            let totalScrollViewFixedWidth = scrollView.frame.size.width
            
            if offset >= (totalContentWidth - totalScrollViewFixedWidth - 120) {
                self?.viewModel.fetchMoreLocation(url: url)
            }
            timer.invalidate()
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionFooter,
            let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: RMLocationLoaderCollectionReusableView.identifier,
            for: indexPath) as? RMLocationLoaderCollectionReusableView else {
            fatalError("Unsupported")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard viewModel.areThereMoreLocationIndicator else {
            return .zero
        }
        return CGSize(width: 100, height: collectionView.frame.height)
    }
}
