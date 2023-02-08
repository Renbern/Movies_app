// MovieData+CoreDataProperties.swift
// Copyright © A.Shchukin. All rights reserved.

import CoreData
import Foundation

public extension MovieData {
    @nonobjc class func fetchRequest() -> NSFetchRequest<MovieData> {
        NSFetchRequest<MovieData>(entityName: "MovieData")
    }

    @NSManaged var runtime: Int64
    @NSManaged var tagline: String?
    @NSManaged var backdropPath: String?
    @NSManaged var overview: String?
    @NSManaged var poster: String?
    @NSManaged var mark: Double
    @NSManaged var title: String?
    @NSManaged var id: Int64
}
