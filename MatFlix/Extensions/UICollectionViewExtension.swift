//
//  CollectionViewExtensions.swift
//  MatFlix
//
//  Created by Matheus Tavares on 06/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import UIKit

extension UICollectionView {
    func showEmptyMessage() {
        let label = UILabel()
        let view = UIView(frame: self.bounds)
        let margins = view.layoutMarginsGuide
        label.text = "No results found. Try changing your search terms."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.sizeToFit()
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0).isActive = true
        label.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0).isActive = true

        self.backgroundView = view
    }

    func restore() {
        self.backgroundView = nil
    }
}

