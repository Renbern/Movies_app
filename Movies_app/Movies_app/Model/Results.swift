// Results.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation

/// Результаты запроса
struct Results: Decodable {
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }

    /// Фильмы
    var movies: [Movie]
}
