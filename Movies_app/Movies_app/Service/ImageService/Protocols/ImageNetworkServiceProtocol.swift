// ImageNetworkServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол загрузки картинки из сети
protocol ImageNetworkServiceProtocol {
    func loadPhoto(byUrl url: String, completion: @escaping (Result<Data, Error>) -> ())
}
