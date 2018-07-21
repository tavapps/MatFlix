//
//  UpcomingMoviesViewController.swift
//  MatFlix
//
//  Created by Matheus Tavares on 05/07/18.
//  Copyright © 2018 Matheus Tavares. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class UpcomingMoviesViewController: BaseViewController {

    //    MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!

    //    MARK: Variables
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search movies"
        return searchController
    }()

    var movieViewModel: MovieListViewModel?
    var searchViewModel: MovieSearchViewModel?

    var disposeBag = DisposeBag()
    var disposableUpcoming: Disposable?
    var disposableSearch: Disposable?
    let searchText = Variable<String?>(nil)

    let reuseIdentifier = "MovieCell"
    let cellNibName = "MovieCell"
    let movieDetailsSegueIdentifier = "showMovieDetails"

    var selectedCell = -1
    var isNewSearch = true

    //    MARK: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        bindUI()
    }

    //    MARK: UI Initialization methods
    private func bindUI() {
        movieViewModel = MovieListViewModel(view: self)
        setupCollectionView()
        setupSearchBar()
        populateUpcomingMoviesCollectionView()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.register(UINib(nibName: cellNibName, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        setupInfinityScroll()

    }

    private func setupCell(movie: Movie, cell: MovieCell, isSearching: Bool) {

        cell.movieViewModel = MovieCellViewModel(movie: movie)

        if(isSearching) {
            cell.infoButton.removeTarget(self, action: #selector(UpcomingMoviesViewController.callMovieDetailsSegue(sender:)), for: .touchUpInside)
            cell.infoButton.addTarget(self, action: #selector(UpcomingMoviesViewController.callMovieDetailsSegueWhileSearching(sender:)), for: .touchUpInside)
        } else {
            cell.infoButton.removeTarget(self, action: #selector(UpcomingMoviesViewController.callMovieDetailsSegueWhileSearching(sender:)), for: .touchUpInside)
            cell.infoButton.addTarget(self, action: #selector(UpcomingMoviesViewController.callMovieDetailsSegue(sender:)), for: .touchUpInside)
        }
    }

    //    MARK: Infinity Scroll Methods
    private func setupInfinityScroll() {
        collectionView.rx.contentOffset
            .flatMap { offset in
                UpcomingMoviesViewController.isNearTheBottomEdge(contentOffset: offset, self.collectionView)
                    ? Observable.just(())
                    : Observable.empty()
            }.throttle(1.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.loadNextPage()
            }).disposed(by: disposeBag)
    }

    private func loadNextPage() {
        if let _ = disposableSearch, let searchViewModel = self.searchViewModel { // search is being made
            if !searchViewModel.getSearchResponse().value.isEmpty {
                searchViewModel.fetchNextPage(view: self)
            }
            return
        }
        if let _ = disposableUpcoming, let movieViewModel = self.movieViewModel, !movieViewModel.getMovies().value.isEmpty {
            movieViewModel.fetchNextPage(view: self)
            return
        }
    }

    static func isNearTheBottomEdge(contentOffset: CGPoint, _ view: UICollectionView) -> Bool {
        return contentOffset.y + view.frame.size.height + view.contentSize.height / 2.3 > view.contentSize.height
    }

    //    MARK: Search Bar Methods
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        bindGenres()
        bindSearchBar()
    }

    private func bindSearchBar() {

        func cancelSearch() {
            self.isNewSearch = true
            self.populateUpcomingMoviesCollectionView()
        }

        searchController.searchBar.rx
            .searchButtonClicked.asObservable()
            .subscribe(onNext: {
                if (self.isNewSearch) {
                    self.bindSearchViewModel()
                }
                guard let query = self.searchController.searchBar.text else {
                    return
                }
                self.searchQuery(query: query, isNew: true)
                self.isNewSearch = false
            }).disposed(by: disposeBag)

        searchController.searchBar.rx.text.asDriver()
            .drive(searchText)
            .disposed(by: disposeBag)

        searchText.asObservable().subscribe(onNext: { [weak self] (val) in
            if let _ = self, let text = val, text.isEmpty {
                cancelSearch()
            }
        })
            .disposed(by: disposeBag)

        searchController.searchBar.rx
            .cancelButtonClicked.asObservable()
            .subscribe(onNext: {
                cancelSearch()
            }).disposed(by: disposeBag)

    }
    
    private func bindGenres(){
        
        movieViewModel!.getGenres().asObservable().take(2) //ensures that on the second time it will be populated
            .subscribe(onNext:{ genres in
                self.searchViewModel = MovieSearchViewModel(genres: genres)
            }).disposed(by: disposeBag)
        
    }

    private func bindSearchViewModel() {
        dispose(disposableUpcoming)
        disposableUpcoming = nil
        self.collectionView.restore()
        //        Security check to see if it wasn't already set
        guard let _ = self.disposableSearch else {
            self.disposableSearch = searchViewModel!
                .getSearchResponse().asObservable()
                .map { movies -> [Movie] in
                    if (movies.isEmpty) {
                        self.collectionView.showEmptyMessage()
                    } else {
                        self.collectionView.restore()
                    }
                    return movies
                }.bind( to: collectionView.rx.items(cellIdentifier: reuseIdentifier, cellType: MovieCell.self)) {
                    (index, model, cell) in

                    self.setupCell(movie: model, cell: cell, isSearching: true)

            }
            return
        }
    }

    private func searchQuery(query: String, isNew: Bool) {
        searchViewModel!.fetchSearchQuery(query: query, isNew: isNew, view: self)
    }

    //  MARK: Upcoming Movies Methods
    private func populateUpcomingMoviesCollectionView() {
        dispose(disposableSearch)
        disposableSearch = nil
        self.collectionView.restore()
//        Security check to see if it wasn't already set
        guard let _ = self.disposableUpcoming else {
            self.disposableUpcoming = movieViewModel!
                .getMovies().asObservable()
                .map { [weak self] movies -> [Movie] in
                    if let this = self {
                        if (movies.isEmpty) {
                            this.collectionView.showEmptyMessage()
                        } else {
                            this.collectionView.restore()
                        }
                    }
                    return movies
                }.bind( to: collectionView.rx.items(cellIdentifier: reuseIdentifier, cellType: MovieCell.self)) {
                    (index, model, cell) in

                    self.setupCell(movie: model, cell: cell, isSearching: false)

            }
            return
        }

    }

    //    MARK: Programatically disposing observers
    func dispose(_ disposable: Disposable?) {
        if let unwrappedDisposable = disposable {
            unwrappedDisposable.dispose()
        }

    }

    //  MARK: Navigation
    @objc func callMovieDetailsSegue(sender: UIButton) {
        let movie = findMovie(index: selectedCell, isSearching: false)
        performSegue(withIdentifier: movieDetailsSegueIdentifier, sender: movie)
    }
    @objc func callMovieDetailsSegueWhileSearching(sender: UIButton) {
        let movie = findMovie(index: selectedCell, isSearching: true)
        performSegue(withIdentifier: movieDetailsSegueIdentifier, sender: movie)
    }

    func findMovie(index: Int, isSearching: Bool) -> MovieDetailsViewModel {
        if(isSearching) {
            let movies = searchViewModel!.getSearchResponse().value
            let movieDetailsViewModel = MovieDetailsViewModel(movie: movies[index])
            return movieDetailsViewModel
        }
        let movies = movieViewModel!.getMovies().value
        let movieDetailsViewModel = MovieDetailsViewModel(movie: movies[index])
        return movieDetailsViewModel
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == movieDetailsSegueIdentifier {

            guard let vc = segue.destination as? MovieDetailsViewController, let movieDetailsViewModel = sender as? MovieDetailsViewModel else {
                return
            }
            vc.movieDetailsViewModel = movieDetailsViewModel
        }

    }

}

// MARK: UICollectionViewDelegate Methods For Layout
extension UpcomingMoviesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // ensures 3 cells per row when in portrait mode
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width / 3.0
        let cellHeight = cellWidth * 1.47

        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    //    MARK: Cell Selection Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = indexPath.row
    }


}
