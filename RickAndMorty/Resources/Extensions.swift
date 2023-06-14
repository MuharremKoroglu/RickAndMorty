//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 11.06.2023.
//

import UIKit

extension UIView {
    func addSubViews (_ views : UIView ...) {
        views.forEach ({
            addSubview($0)
        })
    }
}
