// MoviesListCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

final class MoviesListCoordinator: BaseCoordinator {
    // MARK: - Public properties

    var rootController: UINavigationController?
    var onFinishFlow: VoidHandler?
    var assemblyModuleBuilder: AssemblyBuilderProtocol?

    // MARK: - Initializer

    init(assemblyModuleBuilder: AssemblyBuilderProtocol) {
        self.assemblyModuleBuilder = assemblyModuleBuilder
    }

    // MARK: - Public methods

    override func start() {
        showMoviesModule()
    }

    // MARK: - Private methods

    private func showMoviesModule() {
        guard let controller = assemblyModuleBuilder?.createMoviesListModule() as? MoviesListViewController
        else { return }
        controller.onMovieDetail = { [weak self] id in
            self?.showMovieDetail(id: id)
        }
        let rootController = UINavigationController(rootViewController: controller)
        setAsRoot(rootController)
        self.rootController = rootController
    }

    private func showMovieDetail(id: Int) {
        guard let controller = assemblyModuleBuilder?.createDetailModule(id: id) as? MovieDetailViewController
        else { return }
        rootController?.pushViewController(controller, animated: true)
    }
}
