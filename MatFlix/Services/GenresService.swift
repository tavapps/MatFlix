//
//  GenresService.swift
//  MatFlix
//
//  Created by Matheus Tavares on 05/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import Foundation

struct GenresService : BaseServiceProtocol{
    
    static let sharedInstance = GenresService()
    
    private init (){
        
    }
    
    func getList (params: MovieRequestData, view: BaseViewController? = nil, completion: @escaping serviceCompletion) {
        
        let endpoint = UrlList.sharedInstance.baseUrl + UrlList.sharedInstance.genreListQuery

        createAndHandleRequest(endpoint: endpoint, params: params, view: view, completion: completion)
    }
}
