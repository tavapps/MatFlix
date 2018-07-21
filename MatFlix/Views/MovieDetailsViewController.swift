//
//  MovieDetailsViewController.swift
//  MatFlix
//
//  Created by Matheus Tavares on 05/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class MovieDetailsViewController: BaseViewController, KingfisherProtocol {

    //    MARK: Variables
    var movieDetailsViewModel: MovieDetailsViewModel!

    //    MARK: IBOutlets
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var votingAverageLabel: UILabel!
    @IBOutlet weak var backdropImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

    }

    func setupView() {
        titleLabel.text = movieDetailsViewModel.title
        releaseDateLabel.text = movieDetailsViewModel.releaseDateString
        genreLabel.text = movieDetailsViewModel.genre
        overviewLabel.text = movieDetailsViewModel.overView
        votingAverageLabel.text = movieDetailsViewModel.voteAverageString

        releaseDateLabel.adjustLabelFontToSmallDevices()
        setImageWithTransitionAndLoading(imageUrl: movieDetailsViewModel.imageUrl, imageView: imageView)
        setImageWithTransitionAndLoading(imageUrl: movieDetailsViewModel.backdropUrl, imageView: backdropImage)
        backdropImage.alpha = 0.65
    }
}
