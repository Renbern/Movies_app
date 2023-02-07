// MovieNetworkServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол с методами сетевого слоя
protocol MovieNetworkServiceProtocol {
    func fetchMovies(_ method: RequestType, completion: @escaping (Result<[Movies], Error>) -> Void)

    func fetchDetails(
        movieId: Int,
        completion: @escaping (Result<Details, Error>) -> Void
    )
}
