//
//  UILabelExtension.swift
//  MatFlix
//
//  Created by Matheus Tavares on 06/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import UIKit

extension UILabel{
    func adjustLabelFontToSmallDevices(){
        self.minimumScaleFactor = 0.1
        self.adjustsFontSizeToFitWidth = true
        self.lineBreakMode = .byClipping
        self.numberOfLines = 0
    }
}
