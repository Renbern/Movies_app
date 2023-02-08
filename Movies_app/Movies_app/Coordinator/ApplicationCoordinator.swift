// ApplicationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Координатор запуска приложения
final class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Private properties

    private var assemblyModuleBuilder: AssemblyBuilderProtocol?

    // MARK: - Initializer

    init(assemblyModuleBuilder: AssemblyBuilderProtocol) {
        self.assemblyModuleBuilder = assemblyModuleBuilder
    }

    // MARK: - Public methods

    override func start() {
        guard let assemblyModuleBuilder = assemblyModuleBuilder else { return }
        toMain(assemblyModuleBuilder: assemblyModuleBuilder)
    }

    // MARK: - Private methods

    private func toMain(assemblyModuleBuilder: AssemblyBuilderProtocol) {
        let coordinator = MoviesListCoordinator(assemblyModuleBuilder: assemblyModuleBuilder)
        addDependency(coordinator)
        coordinator.start()
    }
}
