// CoreDataStack.swift
// Copyright © A.Shchukin. All rights reserved.

import CoreData

/// Корд тада
class CoreDataStack {
    private let modelName: String

    init(modelName: String) {
        self.modelName = modelName
    }

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext

    func saveContext(movies: [Movie]) {
        guard let newMovie = NSEntityDescription.entity(forEntityName: "MovieData", in: managedContext) else { return }
        for movie in movies {
            let newMovie = MovieData(entity: newMovie, insertInto: managedContext)
            newMovie.title = movie.title
            newMovie.overview = movie.overview
            newMovie.mark = movie.mark
            newMovie.poster = movie.poster
            newMovie.id = Int64(movie.id)
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
