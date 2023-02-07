// ApplicationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///
final class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Public properties

    override func start() {
        guard let assemblyModuleBuilder = assemblyModuleBuilder else { return }
        toMain(assemblyModuleBuilder: assemblyModuleBuilder)
    }

    var assemblyModuleBuilder: AssemblyBuilderProtocol?

    // MARK: - Initializer

    init(assemblyModuleBuilder: AssemblyBuilderProtocol) {
        self.assemblyModuleBuilder = assemblyModuleBuilder
    }

    // MARK: - Private methods

    private func toMain(assemblyModuleBuilder: AssemblyBuilderProtocol) {
        let coordinator = MoviesListCoordinator(assemblyModuleBuilder: assemblyModuleBuilder)
        addDependency(coordinator)
        coordinator.start()
    }
}
