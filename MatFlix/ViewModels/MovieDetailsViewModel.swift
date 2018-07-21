//
//  MovieDetailsViewModel.swift
//  MatFlix
//
//  Created by Matheus Tavares on 05/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import Foundation

struct MovieDetailsViewModel {

    let title: String
    let genre: String
    let releaseDate: String
    let imageUrl: String
    let backdropUrl: String
    let voteAverage: Double
    let overView: String
    var voteAverageString: String {
        return "⭐️ \(voteAverage)/10"
    }
    var releaseDateString: String {
        let releaseDateArray = releaseDate.split(separator: "-")
        if(releaseDateArray.count == 3){
            return "Release date: \(releaseDateArray[2])/\(releaseDateArray[1])/\(releaseDateArray[0])"
        }else{
            return "Unknown release date"
        }
    }

    init(movie: Movie) {
        title = movie.title ?? "Unknown"
        genre = movie.genre ?? "Unknown"
        releaseDate = movie.releaseDate ?? ""
        voteAverage = movie.voteAverage ?? 0
        overView = movie.overview ?? "No description available"
        backdropUrl = UrlList.sharedInstance.backdropURL + (movie.backdropPath ?? "")
        imageUrl = UrlList.sharedInstance.imageURL + (movie.posterPath ?? "")

    }

}
