// Details.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель детальной информации о фильме
struct Details: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case mark = "vote_average"
        case poster = "poster_path"
        case overview
        case backdropPath = "backdrop_path"
        case tagline
        case runtime
    }

    /// Идентификатор
    let id: Int
    /// Название фильма
    let title: String
    /// Оценка фильма
    let mark: Double
    /// Постер фильма
    let poster: String?
    /// Описаниефильам
    let overview: String
    /// Задний фон экрана
    let backdropPath: String
    /// Слоган фильма
    let tagline: String
    /// Продолжительность фильма
    let runtime: Int
}
