//
//  LoadingIndicatorProtocol.swift
//  MatFlix
//
//  Created by Matheus Tavares on 04/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import UIKit

protocol LoadingIndicatorProtocol {
    mutating func showLoading(isFullScreen: Bool)
    func removeLoading()

//    var subView: UIView {get set}
}

extension LoadingIndicatorProtocol where Self: BaseViewController {
    func showLoading(isFullScreen: Bool) {
        self.view.isUserInteractionEnabled = false

        subView = UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? UIView

        view.addSubview(subView!)

        if(isFullScreen) {
            subView!.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        } else {
            subView!.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            subView!.alpha = 0.85
            subView!.backgroundColor = UIColor.lightGray
            subView!.layer.cornerRadius = 15
            subView!.layer.masksToBounds = true
        }

        subView!.center = CGPoint(x: view.bounds.midX,
                                  y: view.bounds.midY);
    }

    func removeLoading() {
        view.isUserInteractionEnabled = true

        guard let subView = subView else {
            return
        }
        subView.isHidden = true
        subView.removeFromSuperview()
    }
}
