// MockProxyService.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation
@testable import Movies_app

/// Мок прокси сервиса
final class MockProxyService: ProxyProtocol {
    // MARK: - Public methods

    func loadImage(by url: String, completion: @escaping (Result<Data, Error>) -> Void) {}
}
