//
//  MovieSearchService.swift
//  MatFlix
//
//  Created by Matheus Tavares on 05/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import Foundation
import UIKit
struct MovieSearchService: BaseServiceProtocol {
    
    static let sharedInstance = MovieSearchService()
    
    private init (){
        
    }
    
    func getList (params: MovieRequestData, view: BaseViewController? = nil, completion: @escaping serviceCompletion) {
        
        let endpoint = UrlList.sharedInstance.baseUrl + UrlList.sharedInstance.movieSearchQuery
        
        createAndHandleRequest(endpoint: endpoint, params: params, view: view, completion: completion)
    }
    
}
