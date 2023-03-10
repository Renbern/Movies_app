// MovieListViewModelTests.swift
// Copyright © A.Shchukin. All rights reserved.

@testable import Movies_app
import XCTest

/// Тесты вью модели экрана со списком фильмов
final class MovieListViewModelTests: XCTestCase {
    // MARK: - Private properties

    private var movies: [Movie] = []
    private var detail: Details?
    private var keychainService = MockKeychainService()
    private var imageService = MockImageService()
    private var coreDataService = MockCoreDataService()
    private var networkService = MockMovieNetworkService()
    private var moviesListViewModel: MoviesListViewModelProtocol?

    // MARK: - Public methods

    override func setUp() {
        super.setUp()
        moviesListViewModel = MoviesListViewModel(
            movieNetworkService: networkService,
            imageService: imageService,
            keyChainService: keychainService,
            coreDataService: coreDataService
        )
    }

    func testFetchMovies() {
        networkService.fetchMovies(.popular) { [weak self] mockResult in
            guard let self = self else { return }
            switch mockResult {
            case let .success(movies):
                self.movies = movies
                XCTAssertEqual(self.movies.count, UnitTestConstants.moviesCountStub)
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testFetchDetails() {
        networkService.fetchDetails(movieId: UnitTestConstants.movieIdStub) { [weak self] mockResult in
            guard let self = self else { return }
            switch mockResult {
            case let .success(detail):
                self.detail = detail
                XCTAssertNotNil(detail)
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testfetchImage() {
        moviesListViewModel?.fetchImage(imageUrlPath: UnitTestConstants.imagePathStub) { result in
            XCTAssertEqual(result, UnitTestConstants.imagePathStub.data(using: .utf8))
        }
    }

    func testChangeMovieType() {
        moviesListViewModel?.changeMovieType(tag: 0)
        XCTAssertEqual(moviesListViewModel?.currentMovieType, .topRated)
        moviesListViewModel?.changeMovieType(tag: 1)
        XCTAssertEqual(moviesListViewModel?.currentMovieType, .popular)
        moviesListViewModel?.changeMovieType(tag: 2)
        XCTAssertEqual(moviesListViewModel?.currentMovieType, .actual)
        moviesListViewModel?.changeMovieType(tag: 3)
    }
}
