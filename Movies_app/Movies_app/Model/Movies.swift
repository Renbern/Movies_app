// Movies.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель фильмов
struct Movies: Decodable {
    /// Идентификатор
    let id: Int
    /// Название фильма
    let title: String
    /// Оценка фильма
    let mark: Double
    /// Постер фильма
    let poster: String
    /// Описание фильма
    let overview: String

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case mark = "vote_average"
        case poster = "poster_path"
        case overview
    }
}
