// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: ApplicationCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
//        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        let assemblyModuleBuilder = AssemblyModuleBuilder()
        coordinator = ApplicationCoordinator(assemblyModuleBuilder: assemblyModuleBuilder)
        coordinator?.start()
    }
}
