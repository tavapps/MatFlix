//
//  MovieCellViewModel.swift
//  MatFlix
//
//  Created by Matheus Tavares on 05/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import Foundation

struct MovieCellViewModel {
//    private var movie = Variable<Movie>(Movie())

    let title: String
    let genre: String
    let releaseDate: String
    let imageUrl: String
    let id: Int
    var releaseDateString: String {
        let releaseDateArray = releaseDate.split(separator: "-")
        if(releaseDateArray.count == 3){
        return "\(releaseDateArray[2])/\(releaseDateArray[1])/\(releaseDateArray[0])"
        }else{
            return "Unknown"
        }
    }
    
    init(movie: Movie) {
        title = movie.title ?? "Unknown"
        genre = movie.genre ?? "Unknown"
        releaseDate = movie.releaseDate ?? ""
        id = movie.id ?? 0

        if let url = movie.posterPath {
            imageUrl = UrlList.sharedInstance.imageURL + url
        } else {
            imageUrl = UrlList.sharedInstance.imageURL + (movie.backdropPath ?? "")
        }

    }

}
