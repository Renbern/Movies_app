// MockFileManagerService.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation
@testable import Movies_app

/// Мок сервиса файлового менеджера
final class MockFileManagerService: FileManagerServiceProtocol {
    // MARK: - Public methods

    func getImageFromCache(url: String) -> Data? {
        Data()
    }

    func saveImageToCache(url: String, data: Data) {}
}
