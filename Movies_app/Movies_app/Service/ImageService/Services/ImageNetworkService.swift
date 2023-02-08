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
                print(error.localizedDescription)
                return
            }
            guard response is HTTPURLResponse else {
                print(error?.localizedDescription)
                return
            }
            guard let data = data else {
                print(error?.localizedDescription)
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
        dataTask?.resume()
    }
}
