//
//  KeyboardHandlerProtocol.swift
//  MatFlix
//
//  Created by Matheus Tavares on 04/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import UIKit

@objc protocol KeyboardHandlerProtocol{
    func hideKeyboardWhenTappedAround()
    @objc func dismissKeyboard()
}
