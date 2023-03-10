// MockMovieNetworkService.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation
@testable import Movies_app

/// Мок нетворк сервиса
final class MockMovieNetworkService: MovieNetworkServiceProtocol {
    // MARK: - Private Properties

    private var keyChainService: KeyChainServiceProtocol?
    private var movie: [Movie]?
    private var detailStab: Details? = .init(
        id: 0,
        title: "",
        mark: 0.0,
        poster: "",
        overview: "",
        backdropPath: "",
        tagline: "",
        runtime: 0,
        genres: [Genre(name: "")]
    )

    // MARK: - Public Methods

    func fetchMovies(
        _ method: Movies_app.RequestType,
        completion: @escaping (Result<[Movies_app.Movie], Error>) -> Void
    ) {
        guard let jsonURL = Bundle.main.path(
            forResource: UnitTestConstants.movieJson,
            ofType: UnitTestConstants.jsonFormat
        ) else { return }
        do {
            let fileURL = URL(fileURLWithPath: jsonURL)
            let data = try Data(contentsOf: fileURL)
            let result = try JSONDecoder().decode(Results.self, from: data).movies
            completion(.success(result))
        } catch {
            completion(.failure(error))
        }
    }

    func fetchDetails(
        movieId: Int,
        completion: @escaping (Result<Details, Error>) -> Void
    ) {
        if let detail = detailStab {
            completion(.success(detail))
        } else {
            let error = NSError(domain: "", code: .zero)
            completion(.failure(error))
        }
    }
}
