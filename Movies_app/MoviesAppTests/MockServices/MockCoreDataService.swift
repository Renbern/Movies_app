// MockCoreDataService.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation
@testable import Movies_app

/// Мок сервиса загрузки и сохранения данных в базу данных
final class MockCoreDataService: CoreDataServiceProtocol {
    // MARK: - Public Properties

    var showCoreDataAlert: Movies_app.StringHandler?

    // MARK: - Public Methods

    func getData(category: String) -> [Movies_app.Movie] {
        [Movie]()
    }

    func getMovieDetailData(id: Int) -> [Movies_app.DetailData] {
        [DetailData]()
    }

    func saveMoviesContext(movies: [Movies_app.Movie], category: String) {}

    func saveMovieDetailContext(detail: Movies_app.Details) {}
}
