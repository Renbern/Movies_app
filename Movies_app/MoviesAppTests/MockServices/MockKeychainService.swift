// MockKeychainService.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation
@testable import Movies_app

/// Мок кейчейн сервиса
final class MockKeychainService: KeyChainServiceProtocol {
    // MARK: - Public methods

    func getAPIKey(_ key: String) -> String {
        UnitTestConstants.apiKeyStub
    }

    func saveAPIKey(_ value: String, forKey: String) {}
}
