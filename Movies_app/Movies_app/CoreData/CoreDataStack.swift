// CoreDataStack.swift
// Copyright © A.Shchukin. All rights reserved.

import CoreData

/// Кор дата
class CoreDataStack {
    // MARK: - Private properties

    private let modelName: String
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    private lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext

    // MARK: - Initializer

    init(modelName: String) {
        self.modelName = modelName
    }

    // MARK: - Public methods

    func getData(category: String) -> [MovieData] {
        var movieObjects: [MovieData] = []
        let fetchRequest: NSFetchRequest<MovieData> = MovieData.fetchRequest()
        let predicate = NSPredicate(format: "category = %@", category)
        fetchRequest.predicate = predicate
        do {
            movieObjects = try managedContext.fetch(fetchRequest)
            print(storeContainer.persistentStoreDescriptions.first?.url)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return movieObjects
    }

    func getMovieDetailData(id: Int) -> [DetailData] {
        var detailObjects: [DetailData] = []
        let fetchRequest: NSFetchRequest<DetailData> = DetailData.fetchRequest()
        let predicate = NSPredicate(format: "id = %i", id)
        fetchRequest.predicate = predicate
        do {
            detailObjects = try managedContext.fetch(fetchRequest)
//            print(storeContainer.persistentStoreDescriptions.first?.url)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return detailObjects
    }

    func saveMoviesContext(movies: [Movie], category: String) {
        guard let newMovie = NSEntityDescription.entity(
            forEntityName: GlobalConstants.movieDataEntityName,
            in: managedContext
        ) else { return }
        for movie in movies {
            let movieObject = MovieData(entity: newMovie, insertInto: managedContext)
            movieObject.title = movie.title
            movieObject.overview = movie.overview
            movieObject.mark = movie.mark
            movieObject.poster = movie.poster
            movieObject.movieId = Int64(movie.movieId)
            movieObject.id = UUID()
            movieObject.category = category
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("\(GlobalConstants.unresolvedErrorText)\(error), \(error.userInfo)")
            }
        }
    }

    func saveMovieDetailContext(detail: Details) {
        guard let newDetail = NSEntityDescription.entity(
            forEntityName: GlobalConstants.detailDataEntityName,
            in: managedContext
        )
        else { return }
        guard let newGenre = NSEntityDescription.entity(
            forEntityName: GlobalConstants.genreDataEntityName,
            in: managedContext
        )
        else { return }
        let detailObject = DetailData(entity: newDetail, insertInto: managedContext)
        detailObject.id = Int64(detail.id)
        detailObject.title = detail.title
        detailObject.mark = detail.mark
        detailObject.poster = detail.poster
        detailObject.overview = detail.overview
        detailObject.backdropPath = detail.backdropPath
        detailObject.tagline = detail.tagline
        detailObject.runtime = Int64(detail.runtime)
        for genre in detail.genres {
            let genreObject = GenreData(entity: newGenre, insertInto: managedContext)
            genreObject.name = genre.name
            detailObject.addToGenre(genreObject)
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("\(GlobalConstants.unresolvedErrorText)\(error), \(error.userInfo)")
        }
    }

    func saveMovieGenresContext(genre: Genre) {}
}
