//
//  KingfisherProtocol.swift
//  MatFlix
//
//  Created by Matheus Tavares on 06/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import UIKit
import Kingfisher

protocol KingfisherProtocol{
     func setImageWithTransitionAndLoading(imageUrl: String, imageView: UIImageView)
}

extension KingfisherProtocol{
    func setImageWithTransitionAndLoading(imageUrl: String, imageView: UIImageView){
        let url = URL(string: imageUrl)!
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, options: [.transition(.fade(0.3))])
    }
}
