//
//  BaseService.swift
//  MatFlix
//
//  Created by Matheus Tavares on 04/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import Foundation
import UIKit

protocol BaseServiceProtocol: UnwrapperProtocol {
     func setDefaultGetRequest(url: String, params: MovieRequestData) -> URLRequest

    func createAndHandleRequest(endpoint: String, params: MovieRequestData, view: BaseViewController?, completion: @escaping serviceCompletion)

     func handleDefaultError(view: BaseViewController?)

    typealias serviceCompletion = (ResponseData) -> Void
}

extension BaseServiceProtocol {

    func createAndHandleRequest(endpoint: String, params: MovieRequestData, view: BaseViewController?, completion: @escaping serviceCompletion) {

        if let parentView = view {
            parentView.showLoading(isFullScreen: false)
        }

        let request = setDefaultGetRequest(url: endpoint, params: params)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            guard let data = data, error == nil else {
                guard let parentView = view else { return }
                return parentView.showAlert(message: String(describing: error), completion: nil)
            }
            
            let jsonDecoder = JSONDecoder()

            do {
                let result = try jsonDecoder.decode(MovieResponse.self, from: data)

                guard let httpStatus = response as? HTTPURLResponse else {
                    self.handleDefaultError(view: view)
                    return
                }

                DispatchQueue.main.async {

                    if let parentView = view {
                        parentView.removeLoading()
                    }

                    let receivedData = ResponseData(status: httpStatus.statusCode, movieResponse: result)

                    completion(receivedData)

                }

            } catch let err {
                print(err)
                self.handleDefaultError(view: view)
            }

        }
        task.resume()
    }

     func setDefaultGetRequest(url: String, params: MovieRequestData) -> URLRequest {

        var components = URLComponents(string: url)!

        let mirror = Mirror(reflecting: params)
        
        components.queryItems = mirror.children.compactMap {
            
            let value = unwrap($0.value)
            if let name = $0.label , value != ""{
                // security check as name(key) must always be present
                // on unwrap method, it will return "" if the value is nil
                return URLQueryItem(name: name, value: value)
            }else{
                return nil
            }
        }
        print(components.url!)
        var request = URLRequest(url: components.url!, cachePolicy: .useProtocolCachePolicy)
        request.httpMethod = "GET"

        return request
    }
    
    func handleDefaultError(view: BaseViewController?) {
        guard let parentView = view else { return }
        parentView.showDefaultErrorAlert()
    }

}
