// Movies.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation

/// Модель фильмов
struct Movie: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case mark = "vote_average"
        case poster = "poster_path"
        case overview
    }

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
}
