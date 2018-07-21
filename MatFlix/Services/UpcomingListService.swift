//
//  UpcomingListService.swift
//  MatFlix
//
//  Created by Matheus Tavares on 04/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import Foundation
import UIKit

struct UpcomingListService: BaseServiceProtocol {

    static let sharedInstance = UpcomingListService()

    private init() {

    }

    func getList (params: MovieRequestData, view: BaseViewController? = nil, completion: @escaping serviceCompletion) {
        
        let endpoint = UrlList.sharedInstance.baseUrl + UrlList.sharedInstance.upcomingListQuery
        
        createAndHandleRequest(endpoint: endpoint, params: params, view: view, completion: completion)
    }


}
