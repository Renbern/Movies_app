// MovieDetailViewModelTests.swift
// Copyright © A.Shchukin. All rights reserved.

@testable import Movies_app
import XCTest

/// Тесты вью модели экрана с деталями фильма
final class MovieDetailViewModelTests: XCTestCase {
    // MARK: - Private properties

    private var movield = UnitTestConstants.zero
    private var detail: Details?
    private var keychainService = MockKeychainService()
    private var imageService = MockImageService()
    private var coreDataService = MockCoreDataService()
    private var networkService = MockMovieNetworkService()
    private var movieDetailViewModel: MovieDetailViewModelProtocol?

    // MARK: - Public methods

    override func setUp() {
        movieDetailViewModel = MovieDetailViewModel(
            movieNetworkService: networkService,
            id: movield,
            imageService: imageService,
            coreDataService: coreDataService
        )
    }

    func testfetchImage() {
        movieDetailViewModel?.fetchImage(imageURLPath: UnitTestConstants.imagePathStub, completion: { result in
            switch result {
            case let .success(data):
                XCTAssertEqual(data, UnitTestConstants.imagePathStub.data(using: .utf8))
            case let .failure(error):
                print(error)
            }
        })
    }

    func testloadDetailFromCoreData() {
        XCTAssertNoThrow(movieDetailViewModel?.loadDetailFromCoreData(movieId: UnitTestConstants.movieIdStub))
    }
}
