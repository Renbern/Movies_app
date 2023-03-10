// GlobalConstants.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation

/// Константы
enum GlobalConstants {
    static let apiKey = "key"
    static let appDelegateErrorText = "Unexpected app delegate type, did it change? "
    static let persistentContainerErrorText = "Unresolved error "
    static let movieDataEntityName = "MovieData"
    static let detailDataEntityName = "DetailData"
    static let unresolvedErrorText = "Unresolved error "
    static let genreDataEntityName = "GenreData"
    static let movieDataModel = "MovieDataModel"
    static let movieDetailPredicate = "id = %i"
    static let movieCategoryPredcate = "category = %@"
}
