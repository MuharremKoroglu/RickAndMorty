//
//  RMLocationCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 1.07.2023.
//

import Foundation
import UIKit

class RMLocationCollectionViewCell : UICollectionViewCell {
    
    static let cellIndetifier : String = "RMLocationCollectionViewCell"
    
    private var locationName : UILabel = {
        let locationName = UILabel()
        locationName.textColor = .label
        locationName.textAlignment = .center
        locationName.font = .systemFont(ofSize: 15, weight: .bold)
        locationName.translatesAutoresizingMaskIntoConstraints = false
        return locationName
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        setUpConstraints()
        contentView.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints () {
        
        contentView.addSubViews(locationName)
        
        NSLayoutConstraint.activate([
        
            locationName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            locationName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            locationName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            locationName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            
            locationName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2),
            locationName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -2),
        ])
    
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        locationName.text = nil
    }
    
    public func configure (with model : LocationName) {
        self.locationName.text = model.name
    }
    
}
