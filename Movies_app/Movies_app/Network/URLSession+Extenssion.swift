// URLSession+Extenssion.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Метод для получения данных
extension URLSession {
    func fetchData(at url: URL, completion: @escaping (Result<Results, Error>) -> Void) {
        dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }

            if let data = data {
                do {
                    let moviesAPI = try JSONDecoder().decode(Results.self, from: data)
                    completion(.success(moviesAPI))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
}
