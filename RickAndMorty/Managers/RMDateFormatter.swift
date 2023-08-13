//
//  RMDateFormatter.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 4.08.2023.
//

import UIKit

class RMDateFormatter {
    
    static let shared = RMDateFormatter()
    private init () {}
    
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
    
    func formattedDate (with date : String) -> String {

        guard let choosenDate = self.dateFormatter.date(from: date) else {
            return date
        }
        
        let parsedDate = self.originalFormatter.string(from: choosenDate)
        
        return parsedDate
    }
    
}
