// MovieDetailViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель экрана с детальным описанием фильма
final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    // MARK: - Public properties

    var showErrorAlert: ErrorHandler?
    var updateView: VoidHandler?
    var detail: Details?
    var id: Int?

    // MARK: - Private properties

    private var movieNetworkService: MovieNetworkServiceProtocol
    private var imageService: ImageServiceProtocol

    // MARK: - Initializers

    init(
        movieNetworkService: MovieNetworkServiceProtocol,
        id: Int,
        imageService: ImageServiceProtocol
    ) {
        self.movieNetworkService = movieNetworkService
        self.imageService = imageService
        self.id = id
    }

    // MARK: - Public methods

    func fetchDetails() {
        guard let id = id else { return }
        movieNetworkService.fetchDetails(movieId: id) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(details):
                self.detail = details
                self.updateView?()
            case let .failure(error):
                self.showErrorAlert?(error)
            }
        }
    }

    func fetchImage(imageURLPath: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let imageURL = "\(UrlRequest.basePosterURL)\(imageURLPath)"
        imageService.fetchImage(imageURLPath: imageURL, completion: { result in
            switch result {
            case let .success(image):
                completion(.success(image))
            case let .failure(error):
                completion(.failure(error))
            }
        })
    }
}
