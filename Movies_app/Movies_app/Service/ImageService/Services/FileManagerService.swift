// FileManagerService.swift
// Copyright © A.Shchukin. All rights reserved.

import UIKit

/// Сервис работы с файловым менеджером
final class FileManagerService: FileManagerServiceProtocol {
    // MARK: Private Constants

    private enum FileManagerConstants {
        static let pathName = "images"
        static let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
        static let separator: Character = "/"
        static let fileFormat = ".png"
    }

    // MARK: - Private properties

    private static let pathName: String = {
        let pathName = FileManagerConstants.pathName
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        }
        return pathName
    }()

    private let cacheLifeTime: TimeInterval = FileManagerConstants.cacheLifeTime

    // MARK: - Public methods

    func getImageFromCache(url: String) -> Data? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        let lifeTime = Date().timeIntervalSince(modificationDate)
        let fileNameURL = URL(filePath: fileName)
        guard lifeTime <= cacheLifeTime else { return nil }
        do {
            let data = try Data(contentsOf: fileNameURL)
            return data
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }

    func saveImageToCache(url: String, data: Data) {
        guard let fileName = getFilePath(url: url) else { return }
        FileManager.default.createFile(atPath: fileName, contents: data)
    }

    // MARK: - Private methods

    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first,
              let hashName = url.split(separator: FileManagerConstants.separator).last
        else {
            return nil
        }
        return cachesDirectory.appendingPathComponent(
            "\(FileManagerService.pathName)\(String(FileManagerConstants.separator))" +
                "\(hashName)\(FileManagerConstants.fileFormat)"
        ).path
    }
}
