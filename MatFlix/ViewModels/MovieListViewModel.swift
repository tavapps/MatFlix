//
//  MovieListViewModel.swift
//  MatFlix
//
//  Created by Matheus Tavares on 05/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import Foundation
import RxSwift

struct MovieListViewModel {

    private var movieResponse = Variable<MovieResponse>(MovieResponse())
    private var movies = Variable<[Movie]>([])
    private var genres = Variable<[Genre]>([])
    private var disposeBag = DisposeBag()
    private var page = Variable<Int>(1)

    init(view: BaseViewController) {
        fetchGenres(view: view)
    }

    public func getMoviesResponse() -> Variable<MovieResponse> {
        return movieResponse
    }

    public func getMovies() -> Variable<[Movie]> {
        return movies
    }

    public func getGenres() -> Variable<[Genre]> {
        return genres
    }

    func fetchNextPage(view: BaseViewController? = nil) {

        if let totalPages = movieResponse.value.totalPages {

            if(totalPages > page.value) {
                page.value += 1
                fetchUpcomingMovies( view: view)
            }

        } else { //As if you exceed the page limit you will get an empty array, there's no problem to have that if the totalPages are not retrieved
            if(page.value < 1000) { //page limit is 1000
                page.value += 1
                fetchUpcomingMovies( view: view)
            }
        }
    }


    private func fetchUpcomingMovies(view: BaseViewController? = nil) {
        let params = MovieRequestData(page: page.value)

        UpcomingListService.sharedInstance.getList(params: params, view: view) {
            (receivedData) in

            guard let response = receivedData.movieResponse, let page = response.page, let results = response.results else {
                view?.removeLoading()
                return
            }

            self.movieResponse.value = response
            self.movies.value.append(contentsOf: results)
            self.page.value = page
            self.setGenres()

            guard let parentView = view else {
                return
            }
            parentView.removeLoading()
        }

    }

    func fetchGenres(view: BaseViewController? = nil) {
        let params = MovieRequestData()

        GenresService.sharedInstance.getList(params: params, view: view) {
            (receivedData) in

            guard let response = receivedData.movieResponse, let genres = response.genres else {
                view?.removeLoading()
                return
            }

            self.genres.value = genres

            self.fetchUpcomingMovies(view: view)
        }

    }

    func setGenres() {
        if(self.genres.value.count > 1) {

            for (index, movie) in self.movies.value.enumerated() {
                if let genreIds = movie.genreIds, !genreIds.isEmpty {
                    let wrappedGenreList = genres.value.filter({ genreIds[0] == $0.id!
                    }).map({
                        $0.name
                    })

                    self.movies.value[index].genre = wrappedGenreList[0] ?? "Unknown"
                } else {
                    self.movies.value[index].genre = "Unknown"
                }
            }

        }
    }
}
