// MovieDetailViewModel.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation

/// Вью модель экрана с детальным описанием фильма
final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    // MARK: - Public properties

    var coreDataStack = CoreDataStack(modelName: "MovieDataModel")
    var showErrorAlert: ErrorHandler?
    var updateView: VoidHandler?
    var detail: DetailData?
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

    func loadDetailFromCoreData(movieId: Int) {
        loadDetailCoreData(movieId: movieId)
    }

    // MARK: - Private methods

    private func loadDetailCoreData(movieId: Int) {
        let detail = coreDataStack.getMovieDetailData(id: movieId)
        if !detail.isEmpty {
            self.detail = detail.first
        } else {
            fetchDetails()
        }
        updateView?()
    }

    private func fetchDetails() {
        guard let id = id else { return }
        movieNetworkService.fetchDetails(movieId: id) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(details):
                self.coreDataStack.saveMovieDetailContext(detail: details)
                self.detail = self.coreDataStack.getMovieDetailData(id: id).first
                self.updateView?()
            case let .failure(error):
                self.showErrorAlert?(error)
            }
        }
    }
}
