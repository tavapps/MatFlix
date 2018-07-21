//
//  MovieRequestData.swift
//  MatFlix
//
//  Created by Matheus Tavares on 04/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import Foundation

struct MovieRequestData{
    var api_key: String?
    
//    upcoming data variables
    var page: Int?
    var region: String?
    var language: String?
    
//    movie search data may use all the scope
    var query: String?
    var include_adult: Bool?
    var year: Int?
    var primary_release_year: Int?
    
    init(query:String, page: Int){
        self.query = query
        self.page = page
        self.api_key = UrlList.sharedInstance.apiKey
    }
    
    init(page: Int){
        self.page = page
        self.api_key = UrlList.sharedInstance.apiKey
    }
    
    init(){
        self.api_key = UrlList.sharedInstance.apiKey
    }
    
}
