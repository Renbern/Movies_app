// CoreDataServiceProtocol.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation

/// Протокол сервиса CoreData
protocol CoreDataServiceProtocol {
    var showCoreDataAlert: StringHandler? { get set }
    func getData(category: String) -> [Movie]
    func getMovieDetailData(id: Int) -> [DetailData]
    func saveMoviesContext(movies: [Movie], category: String)
    func saveMovieDetailContext(detail: Details)
}
