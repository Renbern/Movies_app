// MoviesListViewModel.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation

/// Вью модель экрана со списком фильмов
final class MoviesListViewModel: MoviesListViewModelProtocol {
    // MARK: - Public properties

    var coreDataStack = CoreDataStack(modelName: "MovieDataModel")
    var showErrorAlert: ErrorHandler?
    var movies: [MovieData]?
    var listMoviesStates: ((ListMovieStates) -> ())?

    // MARK: - Private properties

    private var movieNetworkService: MovieNetworkServiceProtocol
    private var imageService: ImageServiceProtocol
    private var keyChainService: KeyChainServiceProtocol

    // MARK: - Initializers

    init(
        movieNetworkService: MovieNetworkServiceProtocol,
        imageService: ImageServiceProtocol,
        keyChainService: KeyChainServiceProtocol
    ) {
        self.imageService = imageService
        self.movieNetworkService = movieNetworkService
        self.keyChainService = keyChainService
    }

    // MARK: - Public methods

    func loadMoviesFromCoreData(category: RequestType) {
        loadMoviesCoreData(category: category)
    }

    func changeMovieType(tag: Int) {
        switch tag {
        case 0:
            loadMoviesCoreData(category: .topRated)
        case 1:
            loadMoviesCoreData(category: .popular)
        case 2:
            loadMoviesCoreData(category: .actual)
        default:
            return
        }
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
                self.coreDataStack.saveMoviesContext(movies: movies, category: method.urlString)
                self.coreDataStack.getData(category: method.urlString)
            case let .failure(error):
                self.listMoviesStates?(.failure(error))
            }
        }
    }

    private func loadMoviesCoreData(category: RequestType) {
        let movies = coreDataStack.getData(category: category.urlString)
        if !movies.isEmpty {
            self.movies = movies
            listMoviesStates?(.success)
        } else {
            fetchData(category)
        }
    }
}
