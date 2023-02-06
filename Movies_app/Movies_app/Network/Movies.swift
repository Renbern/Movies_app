// Movies.swift
// Copyright © RoadMap. All rights reserved.

/// Результаты запроса
struct Results: Decodable {
    var movies: [Movies]

    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

/// Модель фильмов
struct Movies: Decodable {
    let id: Int
    let title: String
    let mark: Double
    let poster: String
    let overview: String

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case mark = "vote_average"
        case poster = "poster_path"
        case overview
    }
}

/// Модель детальной информации о фильме
struct Details: Decodable {
    let id: Int
    let title: String
    let mark: Double
    let poster: String?
    let overview: String
    let backdropPath: String
    let budget: Int
    let genres: [Genre]
    let adult: Bool
    let releaseDate: String
    let tagline: String
    let runtime: Int

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case mark = "vote_average"
        case poster = "poster_path"
        case overview
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case adult
        case releaseDate = "release_date"
        case tagline
        case runtime
    }
}

/// Модель жанра
struct Genre: Decodable {
    let name: String
}
