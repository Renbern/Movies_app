// AppDelegate.swift
// Copyright © A.Shchukin. All rights reserved.

import CoreData
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static let sharedAppDelegate: AppDelegate = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError(
                "\(GlobalConstants.appDelegateErrorText)\(String(describing: UIApplication.shared.delegate))"
            )
        }
        return delegate
    }()

    lazy var coreDataStack: CoreDataService = .init(modelName: GlobalConstants.movieDataEntityName)

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: GlobalConstants.movieDataEntityName)
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("\(GlobalConstants.persistentContainerErrorText)\(error) \(error.userInfo)")
            }
        })
        return container
    }()
}
