// MoviesListViewModelProtocol.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation

// Протокол вью модели экрана со списком фильмов
protocol MoviesListViewModelProtocol: AnyObject {
    // MARK: - Public properties

    var movies: [Movie]? { get set }
    var showErrorAlert: ErrorHandler? { get set }
    var listMoviesStates: ((ListMovieStates) -> ())? { get set }

    // MARK: - Public methods

    func fetchData(_ method: RequestType)
    func changeMovieType(tag: Int)
    func fetchImage(imageUrlPath: String, handler: @escaping DataHandler)
    func getKeyChain() -> KeyChainServiceProtocol?
}
