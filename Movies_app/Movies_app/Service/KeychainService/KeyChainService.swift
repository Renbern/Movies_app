// KeyChainService.swift
// Copyright © A.Shchukin. All rights reserved.

import KeychainSwift

/// Сервис для сохранения критических данных
final class KeyChainService: KeyChainServiceProtocol {
    // MARK: - Private properties

    private let keychain = KeychainSwift()

    // MARK: - Public methods

    func getAPIKey(_ key: String) -> String {
        guard let keyValue = keychain.get(key) else { return String() }
        return keyValue
    }

    func saveAPIKey(_ value: String, forKey: String) {
        keychain.set(value, forKey: forKey)
    }
}
