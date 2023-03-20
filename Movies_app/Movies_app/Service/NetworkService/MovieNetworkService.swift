// MovieNetworkService.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation

/// Сетевой слой приложения
final class MovieNetworkService: MovieNetworkServiceProtocol {
    // MARK: - Public properties

    var keyChainService: KeyChainServiceProtocol?

    // MARK: - Initializer

    init(keyChainService: KeyChainServiceProtocol) {
        self.keyChainService = keyChainService
    }

    // MARK: - Public methods

    func fetchMovies(_ method: RequestType, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard var urlComponents = URLComponents(string: "\(UrlRequest.baseURL)\(method.urlString)") else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: UrlRequest.apiKey, value: keyChainService?.getAPIKey(GlobalConstants.apiKey)),
            URLQueryItem(name: UrlRequest.languageKey, value: UrlRequest.languageValue)
        ]
        guard let url = urlComponents.url else { return }
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
        guard var urlComponents = URLComponents(string: "\(UrlRequest.baseURL)\(movieId)") else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: UrlRequest.apiKey, value: keyChainService?.getAPIKey(GlobalConstants.apiKey)),
            URLQueryItem(name: UrlRequest.languageKey, value: UrlRequest.languageValue)
        ]
        guard let url = urlComponents.url else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            if let error = error {
                completion(.failure(error))
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
