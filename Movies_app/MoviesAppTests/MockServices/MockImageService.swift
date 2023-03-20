// MockImageService.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation
@testable import Movies_app

/// Мок сервиса загрузки изображений
final class MockImageService: ImageServiceProtocol {
    // MARK: - Public properties

    var image: Data?

    // MARK: - Public methods

    func fetchImage(imageURLPath: String, completion: @escaping (Result<Data, Error>) -> Void) {}
}
