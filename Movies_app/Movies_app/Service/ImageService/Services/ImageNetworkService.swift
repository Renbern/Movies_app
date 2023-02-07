// ImageNetworkService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сервис загрузки картинки из сети
final class ImageNetworkService: ImageNetworkServiceProtocol {
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

    // MARK: - Public methods

//    func loadPhoto(byUrl url: String, completion: @escaping (Result<Data, Error>) -> ()) {
//        guard let imageURL = URL(string: url) else { return }
//        DispatchQueue.global().async {
//            guard let data = try? Data(contentsOf: imageURL),
    ////                  let image = UIImage(data: data)
//            else {
//                return
//            }
    ////            DispatchQueue.main.async {
    ////                self.image = image
    ////            }
//        }
//    }
}
