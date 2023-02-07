// MoviesListViewModelProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Протокол вью модели экрана со списком фильмов
protocol MoviesListViewModelProtocol: AnyObject {
    // MARK: - Public properties

    var movies: [Movies]? { get set }
    var imageService: ImageServiceProtocol { get set }
    var movieNetworkService: MovieNetworkServiceProtocol { get set }
    var showErrorAlert: ErrorHandler? { get set }
    var listMoviesStates: ((ListMovieStates) -> ())? { get set }

    // MARK: - Public methods

    func fetchData(_ method: RequestType)
    func changeMovieType(tag: Int)
    func fetchImage(imageURLPath: String, completion: @escaping (Result<Data, Error>) -> Void)
}
