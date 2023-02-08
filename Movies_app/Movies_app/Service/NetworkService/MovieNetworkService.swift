// MovieNetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сетевой слой приложения
final class MovieNetworkService: MovieNetworkServiceProtocol {
    // MARK: - Public methods

    func fetchMovies(_ method: RequestType, completion: @escaping (Result<[Movies], Error>) -> Void) {
        guard let url =
            URL(
                string: "\(UrlRequest.baseURL)\(method.urlString)\(RequestParameters.apiKey)\(RequestParameters.apiKeyValue)" +
                    "\(RequestParameters.languageKey)\(RequestParameters.ruLanguageValue)"
            )
        else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let moviesAPI = try JSONDecoder().decode(Results.self, from: data).movies
                    completion(.success(moviesAPI))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }

    func fetchDetails(
        movieId: Int,
        completion: @escaping (Result<Details, Error>) -> Void
    ) {
        guard let url =
            URL(
                string: "\(UrlRequest.baseURL)\(movieId)\(UrlRequest.apiKey)\(UrlRequest.ruLanguage)"
            ) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            do {
                let details = try JSONDecoder().decode(Details.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(details))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
