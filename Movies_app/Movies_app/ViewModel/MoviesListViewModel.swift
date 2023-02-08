// MoviesListViewModel.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation

/// Вью модель экрана со списком фильмов
final class MoviesListViewModel: MoviesListViewModelProtocol {
    // MARK: - Public properties
    var coreDataStack = CoreDataStack(modelName: "MovieData")
    var showErrorAlert: ErrorHandler?
    var movies: [Movie]?
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

    func changeMovieType(tag: Int) {
        switch tag {
        case 0:
            fetchData(.topRated)
        case 1:
            fetchData(.popular)
        case 2:
            fetchData(.actual)
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

    func fetchData(_ method: RequestType) {
        movieNetworkService.fetchMovies(method) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.movies = movies
                self.coreDataStack.saveContext(movies: movies)
                self.listMoviesStates?(.success)
            case let .failure(error):
                self.listMoviesStates?(.failure(error))
            }
        }
    }
}
