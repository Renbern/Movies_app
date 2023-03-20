// MovieDetailViewModelProtocol.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation

/// Протокол вью модели экрана деталей фильма
protocol MovieDetailViewModelProtocol: AnyObject {
    // MARK: - Public properties

    var detail: DetailData? { get set }
    var id: Int? { get set }
    var updateView: VoidHandler? { get set }
    var showErrorAlert: ErrorHandler? { get set }

    // MARK: - Public methods

    func loadDetailFromCoreData(movieId: Int)
    func fetchImage(imageURLPath: String, completion: @escaping (Result<Data, Error>) -> Void)
}
