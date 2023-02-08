// AppDelegate.swift
// Copyright © A.Shchukin. All rights reserved.

import CoreData
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static let sharedAppDelegate: AppDelegate = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError(
                "Unexpected app delegate type, did it change? \(String(describing: UIApplication.shared.delegate))"
            )
        }
        return delegate
    }()

    lazy var coreDataStack: CoreDataStack = .init(modelName: "MovieData")

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieData")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
