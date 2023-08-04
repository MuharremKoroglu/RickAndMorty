//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 27.07.2023.
//

import UIKit

class RMEpisodeDetailViewController: UIViewController, RMEpisodeDetailViewDelegate {
    
    
    private let viewModel : RMEpisodeDetailViewViewModel
    private let episodeDetailView : RMEpisodeDetailView
    
    init(viewModel : RMEpisodeDetailViewViewModel) {
        self.viewModel = viewModel
        self.episodeDetailView = RMEpisodeDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        episodeDetailView.delegate = self
        title = "Episode"
        view.addSubview(episodeDetailView)
        setUpConstraints()
        
    }
    
    private func setUpConstraints () {
        
        NSLayoutConstraint.activate([
        
            episodeDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeDetailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeDetailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }
    
    func selectedCharacter(_ detailView: RMEpisodeDetailView, selectedCaharacter: Character) {
        let viewModel = RMCharacterDetailViewViewModel(character: selectedCaharacter)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }


}
