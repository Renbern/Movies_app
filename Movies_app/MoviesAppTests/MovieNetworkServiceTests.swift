// MovieNetworkServiceTests.swift
// Copyright © A.Shchukin. All rights reserved.

@testable import Movies_app
import XCTest

/// Тесты сетевого слоя
final class MovieNetworkServiceTests: XCTestCase {
    // MARK: - Private Properties

    private let keyChainService = MockKeychainService()
    private var networkService: MovieNetworkServiceProtocol?
    private var movies: [Movie] = []

    // MARK: - Public Methods

    override func setUp() {
        super.setUp()
        networkService = MovieNetworkService(keyChainService: keyChainService)
    }

    override func tearDown() {
        super.tearDown()
        networkService = nil
    }

    func testFetchMovie() {
        networkService?.fetchMovies(.popular, completion: { [weak self] mockResult in
            guard let self = self else { return }
            switch mockResult {
            case let .success(success):
                self.movies = success
                XCTAssertEqual(self.movies.count, UnitTestConstants.moviesCountStub)
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        })
    }

    func testFetchDetails() {
        let stubMovieDetail = Details(
            id: UnitTestConstants.movieIdStub,
            title: "",
            mark: 0.0,
            poster: "",
            overview: "",
            backdropPath: "",
            tagline: "",
            runtime: 0,
            genres: [Genre(name: "")]
        )
        networkService?.fetchDetails(movieId: UnitTestConstants.movieIdStub, completion: { result in
            switch result {
            case let .success(detail):
                XCTAssertNotNil(detail)
                XCTAssertEqual(detail.id, stubMovieDetail.id)
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        })
    }
}
