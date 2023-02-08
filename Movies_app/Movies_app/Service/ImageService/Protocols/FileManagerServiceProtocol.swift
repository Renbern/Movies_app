// FileManagerServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол работы с файловым менеджером
protocol FileManagerServiceProtocol {
    func getImageFromCache(url: String) -> Data?
    func saveImageToCache(url: String, data: Data)
}
