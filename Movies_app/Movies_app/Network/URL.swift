// URL.swift
// Copyright © RoadMap. All rights reserved.

/// Блоки URL запроса
enum UrlRequest {
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static let basePosterURL = "https://image.tmdb.org/t/p/w500"
    static let topRated = "top_rated"
    static let popularURL = "popular"
    static let actualURL = "upcoming"
    static let apiKey = "?api_key=5cc552e34f7eb492b6f65e0e324d397b"
    static let ruLanguage = "&language=ru-RU"
    static let engLanguage = "&language=en-EN"
}
