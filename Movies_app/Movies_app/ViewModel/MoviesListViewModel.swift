// MoviesListViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель экрана со списком фильмов
final class MoviesListViewModel: MoviesListViewModelProtocol {
    // MARK: - Public properties

    var showErrorAlert: ErrorHandler?
    var movies: [Movie]?
    var listMoviesStates: ((ListMovieStates) -> ())?

    // MARK: - Private properties

    private var movieNetworkService: MovieNetworkServiceProtocol
    private var imageService: ImageServiceProtocol

    // MARK: - Initializers

    init(
        movieNetworkService: MovieNetworkServiceProtocol,
        imageService: ImageServiceProtocol
    ) {
        self.imageService = imageService
        self.movieNetworkService = movieNetworkService
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
                self.listMoviesStates?(.success)
            case let .failure(error):
                self.listMoviesStates?(.failure(error))
            }
        }
    }
}
