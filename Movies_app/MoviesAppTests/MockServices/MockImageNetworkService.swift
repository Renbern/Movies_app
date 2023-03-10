// MockImageNetworkService.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation
@testable import Movies_app

/// Мок класса загрузки изображения из сети
final class MockImageNetworkService: ImageNetworkServiceProtocol {
    // MARK: - Public methods

    func loadPhoto(byUrl url: String, completion: @escaping (Result<Data, Error>) -> ()) {}
}
