//
//  RMEpisodeViewController.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 10.06.2023.
//

import UIKit

class RMEpisodeViewController: UIViewController, RMEpisodeViewDelegate {

    private let episodeView = RMEpisodeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        episodeView.delegate = self
        setUpViews()
    }
    
    private func setUpViews () {
        
        view.addSubViews(episodeView)
        NSLayoutConstraint.activate([
        
            episodeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

    }
    
    func rmEpisodeViewDelegate(_ episodeView: RMEpisodeView, selectedEpisode: EpisodeInfo) {
        let viewModel = RMEpisodeDetailViewViewModel(episode: selectedEpisode)
        let vc = RMEpisodeDetailViewController(viewModel: viewModel)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

}
