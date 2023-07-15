//
//  RMLocationLoaderCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 11.07.2023.
//

import UIKit

class RMLocationLoaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "RMLocationLoaderCollectionReusableView"
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(spinner)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints () {
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
    }
    
    func startAnimating () {
        spinner.startAnimating()
    }

}
