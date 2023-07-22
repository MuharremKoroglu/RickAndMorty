//
//  RMCharacterDetailViewInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 20.07.2023.
//

import UIKit

class RMCharacterDetailViewInfoCollectionViewCellViewModel {
    
    private let contentType : ContentType
    private let sectionContent : String
    
    var sectionTitle : String {
        contentType.displayTitle
    }
    
    private let dateFormatter : DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter
    }()
    
    private let originalFormatter : DateFormatter = {
        var originalFormatter = DateFormatter()
        originalFormatter.dateFormat = "d MMMM yyyy, HH:mm:ss"
        originalFormatter.locale = Locale(identifier: "en_US")
        return originalFormatter
    }()
    
    var displayContent : String {
        if sectionContent.isEmpty {return "None"}
        if contentType == .created {
            if let date = self.dateFormatter.date(from: self.sectionContent) {
                return self.originalFormatter.string(from: date)
            }
        }

        return sectionContent
    }
    
    var contentIcon : UIImage? {
        return contentType.sectionIcon
    }
    
    var sectionColor : UIColor {
        return contentType.sectionColor
    }
    
    enum ContentType : String {
        case status
        case species
        case type
        case gender
        case origin
        case location
        case episodeCount
        case created
        
        var sectionIcon : UIImage? {
            switch self {
            case .status :
                return UIImage(systemName: "person.fill.checkmark")
            case .species :
                return UIImage(systemName: "person.3.fill")
            case .type :
                return UIImage(systemName: "person.2.fill")
            case .gender :
                return UIImage(systemName: "figure.dress.line.vertical.figure")
            case .origin :
                return UIImage(systemName: "globe.europe.africa.fill")
            case .location :
                return UIImage(systemName: "mappin.and.ellipse")
            case .episodeCount :
                return UIImage(systemName: "tv.fill")
            case .created :
                return UIImage(systemName: "calendar")
            }
        }
        
        
        var sectionColor : UIColor {
            switch self {
            case .status :
                return .systemBlue
            case .species :
                return .systemRed
            case .type :
                return .systemPink
            case .gender :
                return .systemOrange
            case .origin :
                return .systemBrown
            case .location :
                return .systemPurple
            case .episodeCount :
                return .systemYellow
            case .created :
                return .systemMint
            }
        }
    
        var displayTitle : String {
            switch self {
            case .status,
                 .species,
                 .type,
                 .gender,
                 .origin,
                 .location,
                 .created :
                return rawValue.uppercased()
            case .episodeCount :
                return "EPISODE COUNT"
            }
        }
    }
    
    init(sectionContent: String, contentType : ContentType) {
        self.contentType = contentType
        self.sectionContent = sectionContent
    }
    
    
    
    
}
