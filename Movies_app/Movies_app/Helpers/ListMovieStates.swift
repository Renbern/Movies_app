// ListMovieStates.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Список состояний экрана
enum ListMovieStates {
    case initial
    case success
    case failure(Error)
}
