//
//  MovieResponse.swift
//  MatFlix
//
//  Created by Matheus Tavares on 04/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import Foundation

struct MovieResponse: Codable{
    
    var page: Int?
    var results: [Movie]?
    var dates: UpcomingMoviesResponseDates?
    var totalPages: Int?
    var totalResults: Int?
    var genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
       
        case page
        case results
        case dates
        case genres
        
        case totalPages = "total_pages"
        case totalResults = "total_results"
        
    }
    
}
