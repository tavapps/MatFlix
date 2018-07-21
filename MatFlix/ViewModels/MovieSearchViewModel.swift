//
//  MovieSearchViewModel.swift
//  MatFlix
//
//  Created by Matheus Tavares on 06/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import Foundation
import RxSwift

struct MovieSearchViewModel {

    private var movieResponse = Variable<MovieResponse>(MovieResponse())
    private var movies = Variable<[Movie]>([])
    private var genres = Variable<[Genre]>([])
    private var disposeBag = DisposeBag()
    private var page = Variable<Int>(1)
    private var query = Variable<String>("")

    init(genres: [Genre]) {
        self.genres.value = genres
    }

    public func getSearchResponse() -> Variable<[Movie]> {
        return movies
    }
    public func getMovieResponse() -> Variable<MovieResponse> {
        return movieResponse
    }

    func fetchNextPage(view: BaseViewController? = nil) {

        if let totalPages = movieResponse.value.totalPages {

            if(totalPages > page.value) {
                fetchSearchQuery(query: self.query.value, isNew: false, view: view)
            }

        } else { //As if you exceed the page limit you will get an empty array, there's no problem to have that if the totalPages are not retrieved
            if(page.value < 1000) { //page limit is 1000
                fetchSearchQuery(query: self.query.value, isNew: false, view: view)
            }
        }
    }

    func fetchSearchQuery(query: String, isNew: Bool, view: BaseViewController? = nil) {
        self.query.value = query
        let page = isNew ? 1 : self.page.value
        let params = MovieRequestData(query: query, page: page)
        MovieSearchService.sharedInstance.getList(params: params) {
            (receivedData) in

            guard let response = receivedData.movieResponse, let page = response.page, let results = response.results else {
                view?.removeLoading()
                return
            }

            self.movieResponse.value = response
            if(isNew) {
                self.movies.value = results
            } else {
                self.movies.value.append(contentsOf: results)
            }

            self.page.value = page
            self.setGenres()

            guard let parentView = view else {
                return
            }
            parentView.removeLoading()
        }

    }

    func setGenres() {
        if(self.genres.value.count > 1) {

            for (index, movie) in self.movies.value.enumerated() {
                if let genreIds = movie.genreIds, !genreIds.isEmpty  {
                    let wrappedGenreList = genres.value.filter({ genreIds[0] == $0.id!
                    }).map({
                        $0.name
                    })

                    self.movies.value[index].genre = wrappedGenreList[0] ?? ""
                } else {
                    self.movies.value[index].genre = ""
                }
            }

        }
    }
}
