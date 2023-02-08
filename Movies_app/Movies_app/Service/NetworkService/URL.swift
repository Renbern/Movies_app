// URL.swift
// Copyright © A.Shchukin. All rights reserved.

/// Блоки URL запроса
enum UrlRequest {
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static let basePosterURL = "https://image.tmdb.org/t/p/w500"
    static let apiKey = "api_key"
    static let apiKeyValue = "5cc552e34f7eb492b6f65e0e324d397b"
    static let languageKey = "language"
    static let languageValue = "ru-RU"
}

/// Tипы запросов
enum RequestType {
    case topRated
    case popular
    case actual

    var urlString: String {
        switch self {
        case .topRated:
            return "top_rated"
        case .popular:
            return "popular"
        case .actual:
            return "upcoming"
        }
    }
}

/// Параметры запроса
enum RequestParameters {
    static let languageKey = "&language="
    static let apiKey = "?api_key="
    static let keyChainKey = "movieAPIkey"
    static let ruLanguageValue = "ru-RU"
    static let engLanguageValue = "en-EN"
    static let apiKeyValue = "5e95e9b030369d612dfb2d6ecdfb4cf2"
    static let results = "results"
}
