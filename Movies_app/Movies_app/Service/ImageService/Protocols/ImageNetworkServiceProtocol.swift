// ImageNetworkServiceProtocol.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation

/// Протокол загрузки картинки из сети
protocol ImageNetworkServiceProtocol {
    func loadPhoto(byUrl url: String, completion: @escaping (Result<Data, Error>) -> ())
}
