// MovieData+CoreDataProperties.swift
// Copyright © A.Shchukin. All rights reserved.

import CoreData
import Foundation

extension MovieData: Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieData> {
        NSFetchRequest<MovieData>(entityName: "MovieData")
    }

    @NSManaged public var runtime: Int64
    @NSManaged public var tagline: String?
    @NSManaged public var backdropPath: String?
    @NSManaged public var overview: String?
    @NSManaged public var poster: String?
    @NSManaged public var mark: Double
    @NSManaged public var title: String?
    @NSManaged public var movieId: Int64
    @NSManaged public var category: String?
    @NSManaged public var id: UUID?
}
