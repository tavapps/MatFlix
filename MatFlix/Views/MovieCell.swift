//
//  MovieCell.swift
//  MatFlix
//
//  Created by Matheus Tavares on 05/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import Foundation
import UIKit

class MovieCell: UICollectionViewCell, KingfisherProtocol {

    //    MARK: Variables
    var movieViewModel: MovieCellViewModel! {
        didSet {
            setupCellUI()
        }
    }

    override var isSelected: Bool {
        didSet {
            isSelected ? selectCell() : deselectCell()
        }
    }

    //    MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!

    //    MARK: UI Handler Methods
    fileprivate func setupCellUI() {
        titleLabel.text = movieViewModel.title
        releaseDateLabel.text = movieViewModel.releaseDateString
        genreLabel.text = movieViewModel.genre

        hideElements(shouldHide: true)

        setImageWithTransitionAndLoading(imageUrl: movieViewModel.imageUrl, imageView: imageView)
        
        genreLabel.adjustLabelFontToSmallDevices()
        titleLabel.adjustLabelFontToSmallDevices()
        releaseDateLabel.adjustLabelFontToSmallDevices()
    }

    func selectCell() {
        self.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.35) {
            self.hideElements(shouldHide: false)
        }
    }

    func deselectCell() {
        self.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.35) {
            self.hideElements(shouldHide: true)
        }
    }

    func hideElements(shouldHide: Bool) {
        infoButton.alpha = shouldHide ? 0 : 1
        titleLabel.alpha = shouldHide ? 0 : 1
        genreLabel.alpha = shouldHide ? 0 : 1
        imageView.alpha = shouldHide ? 1 : 0.2
    }

}
