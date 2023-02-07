// ProxyService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сервис прокси
final class ProxyService: ProxyProtocol {
    // MARK: - Public properties

    let imageNetworkService: ImageNetworkServiceProtocol
    let fileManagerService: FileManagerServiceProtocol

    // MARK: - Initializer

    init(imageNetworkService: ImageNetworkServiceProtocol, fileManagerService: FileManagerServiceProtocol) {
        self.imageNetworkService = imageNetworkService
        self.fileManagerService = fileManagerService
    }

    // MARK: - Public methods

    func loadImage(by url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let image = fileManagerService.getImageFromCache(url: url) else {
            imageNetworkService.loadPhoto(byUrl: url) { result in
                switch result {
                case let .success(data):
                    self.fileManagerService.saveImageToCache(url: url, data: data)
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
            return
        }
        completion(.success(image))
    }
}
