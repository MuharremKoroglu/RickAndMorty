//
//  RMEpisodeView.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 23.07.2023.
//

import UIKit

protocol RMEpisodeViewDelegate : AnyObject {
    func rmEpisodeViewDelegate (
        _ episodeView : RMEpisodeView,
        selectedEpisode : EpisodeInfo
    )
}

class RMEpisodeView : UIView , UITableViewDelegate, UITableViewDataSource,RMEpisodeViewModelDelegate, UIScrollViewDelegate {

    weak var delegate : RMEpisodeViewDelegate?
    let viewModel = RMEpisodeViewModel()

    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .systemGreen
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        tableView.register(RMEpisodeTableViewCell.self, forCellReuseIdentifier: RMEpisodeTableViewCell.cellIdentifier)
        tableView.isHidden = true
        tableView.alpha = 0
        return tableView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        setUpConstraints()
        setUpTableView()
        viewModel.delegate = self
        viewModel.fetchEpisodes(request: RMRequest(endPoints: .episode))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func didLoadEpisode() {
        spinner.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
        
        UIView.animate(withDuration: 0.4) {
            self.tableView.alpha = 1
        }
        
    }
    
    private func setUpConstraints() {
        
        addSubViews(spinner,tableView)
        
        NSLayoutConstraint.activate([
            
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),

        ])

    }
    
    private func setUpTableView () {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedEpisode = viewModel.episodes[indexPath.row]
        self.delegate?.rmEpisodeViewDelegate(self, selectedEpisode: selectedEpisode)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RMEpisodeTableViewCell.cellIdentifier,
            for: indexPath
        ) as? RMEpisodeTableViewCell else {
            fatalError("This cell not supported!")
        }
        cell.configure(with: viewModel.episodes[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard viewModel.areThereMoreEpisodeIndicator,
              !viewModel.isLoadMoreEpisode,
              !viewModel.episodes.isEmpty else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [ weak self ] timer in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                if self?.viewModel.areThereMoreEpisodeIndicator == true {
                    self?.showLoadingIndicator()
                    self?.viewModel.fetchMoreEpisode()
                }else {
                    self?.spinner.stopAnimating()
                    self?.tableView.tableFooterView = nil
                }
                self?.tableView.reloadData()

            }
            timer.invalidate()
        }

    }
    
    private func showLoadingIndicator() {
        let footer = RMTableLoadingFooterView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 100))
        tableView.tableFooterView = footer
    }
    

}
