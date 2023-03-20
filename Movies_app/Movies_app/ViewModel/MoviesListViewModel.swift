// MoviesListViewModel.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation

/// Вью модель экрана со списком фильмов
final class MoviesListViewModel: MoviesListViewModelProtocol {
    // MARK: - Public properties

    var showErrorAlert: ErrorHandler?
    var showCoreDataAlert: StringHandler?
    var movies: [Movie]?
    var listMoviesStates: ((ListMovieStates) -> ())?
    var currentMovieType: RequestType = .topRated

    // MARK: - Private properties

    private var movieNetworkService: MovieNetworkServiceProtocol
    private var imageService: ImageServiceProtocol
    private var keyChainService: KeyChainServiceProtocol
    private var coreDataService: CoreDataServiceProtocol

    // MARK: - Initializers

    init(
        movieNetworkService: MovieNetworkServiceProtocol,
        imageService: ImageServiceProtocol,
        keyChainService: KeyChainServiceProtocol,
        coreDataService: CoreDataServiceProtocol
    ) {
        self.imageService = imageService
        self.movieNetworkService = movieNetworkService
        self.keyChainService = keyChainService
        self.coreDataService = coreDataService
    }

    // MARK: - Public methods

    func loadMoviesFromCoreData(category: RequestType) {
        loadMoviesCoreData(category: category)
    }

    func changeMovieType(tag: Int) {
        switch tag {
        case 0:
            currentMovieType = .topRated
        case 1:
            currentMovieType = .popular
        case 2:
            currentMovieType = .actual
        default:
            return
        }
        loadMoviesCoreData(category: currentMovieType)
    }

    func getKeyChain() -> KeyChainServiceProtocol? {
        keyChainService
    }

    func fetchImage(imageUrlPath: String, handler: @escaping DataHandler) {
        let imageURL = "\(UrlRequest.basePosterURL)\(imageUrlPath)"
        imageService.fetchImage(imageURLPath: imageURL) { [weak self] result in
            switch result {
            case let .success(data):
                handler(data)
            case let .failure(error):
                self?.showErrorAlert?(error)
            }
        }
    }

    // MARK: - Private methods

    private func fetchData(_ method: RequestType) {
        movieNetworkService.fetchMovies(method) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.coreDataService.saveMoviesContext(movies: movies, category: method.urlString)
                self.movies = movies
                self.listMoviesStates?(.success)
            case let .failure(error):
                self.listMoviesStates?(.failure(error))
            }
        }
    }

    private func loadMoviesCoreData(category: RequestType) {
        let movies = coreDataService.getData(category: category.urlString)
        if !movies.isEmpty {
            self.movies = movies
            listMoviesStates?(.success)
        } else {
            fetchData(category)
        }
    }
}
