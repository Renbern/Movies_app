// DetailData+CoreDataProperties.swift
// Copyright © A.Shchukin. All rights reserved.

import CoreData
import Foundation

public extension DetailData {
    @nonobjc class func fetchRequest() -> NSFetchRequest<DetailData> {
        NSFetchRequest<DetailData>(entityName: GlobalConstants.detailDataEntityName)
    }

    @NSManaged var runtime: Int64
    @NSManaged var tagline: String?
    @NSManaged var backdropPath: String?
    @NSManaged var overview: String?
    @NSManaged var poster: String?
    @NSManaged var mark: Double
    @NSManaged var title: String?
    @NSManaged var id: Int64
    @NSManaged var genre: NSSet?
}

// MARK: Generated accessors for genre

public extension DetailData {
    @objc(addGenreObject:)
    @NSManaged func addToGenre(_ value: GenreData)

    @objc(removeGenreObject:)
    @NSManaged func removeFromGenre(_ value: GenreData)

    @objc(addGenre:)
    @NSManaged func addToGenre(_ values: NSSet)

    @objc(removeGenre:)
    @NSManaged func removeFromGenre(_ values: NSSet)
}
