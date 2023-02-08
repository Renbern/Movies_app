// ImageNetworkService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сервис загрузки картинки из сети
final class ImageNetworkService: ImageNetworkServiceProtocol {
    // MARK: - Public properties

    private var dataTask: URLSessionDataTask?

    // MARK: - Public Methods

    func loadPhoto(byUrl url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: url) else { return }

        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard response is HTTPURLResponse else {
                return
            }
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
        dataTask?.resume()
    }
}
