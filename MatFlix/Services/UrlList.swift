//
//  UrlList.swift
//  MatFlix
//
//  Created by Matheus Tavares on 04/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import Foundation

class UrlList{
    
    let baseUrl = "https://api.themoviedb.org/3"
    let imageURL = "https://image.tmdb.org/t/p/w300"
    let backdropURL = "https://image.tmdb.org/t/p/w1280"
    let apiKey = "1f54bd990f1cdfb230adb312546d765d"
    
    let upcomingListQuery = "/movie/upcoming"
    let movieSearchQuery = "/search/movie"
    let genreListQuery = "/genre/movie/list"
    
    static let sharedInstance = UrlList()
    
    private init(){
        
    }
}
