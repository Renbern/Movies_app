// Results.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Результаты запроса
struct Results: Decodable {
    /// Фильмы
    var movies: [Movies]

    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
