// ProxyService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сервис прокси
final class ProxyService: ProxyProtocol {
    // MARK: - Private properties

    private let imageNetworkService: ImageNetworkServiceProtocol
    private let fileManagerService: FileManagerServiceProtocol

    // MARK: - Initializer

    init(imageNetworkService: ImageNetworkServiceProtocol, fileManagerService: FileManagerServiceProtocol) {
        self.imageNetworkService = imageNetworkService
        self.fileManagerService = fileManagerService
    }

    // MARK: - Public methods

    func loadImage(by url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let image = fileManagerService.getImageFromCache(url: url) else {
            imageNetworkService.loadPhoto(byUrl: url) { [weak self] result in
                guard let self = self else { return }
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
