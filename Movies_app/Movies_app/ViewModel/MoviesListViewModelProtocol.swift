// MoviesListViewModelProtocol.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation

// Протокол вью модели экрана со списком фильмов
protocol MoviesListViewModelProtocol: AnyObject {
    // MARK: - Public properties

    var movies: [Movie]? { get set }
    var showErrorAlert: ErrorHandler? { get set }
    var showCoreDataAlert: StringHandler? { get set }
    var listMoviesStates: ((ListMovieStates) -> ())? { get set }

    // MARK: - Public methods

    func changeMovieType(tag: Int)
    func fetchImage(imageUrlPath: String, handler: @escaping DataHandler)
    func getKeyChain() -> KeyChainServiceProtocol?
    func loadMoviesFromCoreData(category: RequestType)
}
