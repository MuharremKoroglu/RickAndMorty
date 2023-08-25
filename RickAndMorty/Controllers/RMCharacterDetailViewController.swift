//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 10.07.2023.
//

import UIKit

class RMCharacterDetailViewController: UIViewController, RMCharacterDetailViewDelegate {

    private var viewModel : RMCharacterDetailViewViewModel
    private let characterDetailView : RMCharacterDetailView
    
    init(viewModel : RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        self.characterDetailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        self.characterDetailView.delegate = self

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(characterDetailView)
        setUpConstraints()
    }
    
    private func setUpConstraints () {
        NSLayoutConstraint.activate([
        
            characterDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterDetailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterDetailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }
    
    func selectedEpisode(_ detailView: RMCharacterDetailView, selectedEpisode: EpisodeInfo) {
        let service : RMApiCallService = RMApiCall()
        let viewModel = RMEpisodeDetailViewViewModel(episode: selectedEpisode, service: service)
        let detailVC = RMEpisodeDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
