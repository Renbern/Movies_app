// MovieNetworkServiceProtocol.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation

/// Протокол с методами сетевого слоя
protocol MovieNetworkServiceProtocol {
    func fetchMovies(_ method: RequestType, completion: @escaping (Result<[Movie], Error>) -> Void)

    func fetchDetails(
        movieId: Int,
        completion: @escaping (Result<Details, Error>) -> Void
    )
}
