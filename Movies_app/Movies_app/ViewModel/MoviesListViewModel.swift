// MoviesListViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель экрана со списком фильмов
final class MoviesListViewModel: MoviesListViewModelProtocol {
    // MARK: - Public properties

    var showErrorAlert: ErrorHandler?
    var movies: [Movies]?
    var movieNetworkService: MovieNetworkServiceProtocol
    var imageService: ImageServiceProtocol
    var listMoviesStates: ((ListMovieStates) -> ())?

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

    func fetchImage(imageURLPath: String, completion: @escaping (Result<Data, Error>) -> Void) {
        imageService.fetchImage(imageURLPath: imageURLPath, completion: { result in
            switch result {
            case let .success(image):
                completion(.success(image))
            case let .failure(error):
                completion(.failure(error))
            }
        })
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
