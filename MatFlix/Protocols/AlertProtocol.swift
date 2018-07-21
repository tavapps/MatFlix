//
//  AlertProtocol.swift
//  MatFlix
//
//  Created by Matheus Tavares on 04/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import UIKit

protocol AlertProtocol: LoadingIndicatorProtocol {
    func showAlert (message: String, completion: ((UIAlertAction) -> Void)?)
    func showDefaultErrorAlert()
}

extension AlertProtocol where Self: UIViewController {
    func showAlert (message: String, completion: ((UIAlertAction) -> Void)?) {
        //        shows alert with custom message and completion block
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showDefaultErrorAlert() {
        //        shows default error alert
        self.showAlert(message: "An error happened. Please contact our support") {
            _ in
            self.removeLoading()
        }
    }
}
