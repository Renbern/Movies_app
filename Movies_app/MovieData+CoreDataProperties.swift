// MovieData+CoreDataProperties.swift
// Copyright © A.Shchukin. All rights reserved.

import CoreData
import Foundation

extension MovieData: Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieData> {
        NSFetchRequest<MovieData>(entityName: GlobalConstants.movieDataEntityName)
    }

    /// Длительность фильма
    @NSManaged public var runtime: Int64
    /// Слоган
    @NSManaged public var tagline: String?
    /// Фоновое изображение
    @NSManaged public var backdropPath: String?
    /// Описание
    @NSManaged public var overview: String?
    /// Постер
    @NSManaged public var poster: String?
    /// Оценка
    @NSManaged public var mark: Double
    /// Название
    @NSManaged public var title: String?
    /// Идентификатор CoreCata
    @NSManaged public var movieId: Int64
    /// Категория
    @NSManaged public var category: String?
    /// Идентификатор
    @NSManaged public var id: UUID?
}
