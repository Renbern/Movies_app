// ProxyProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол загрузки изображения
protocol ProxyProtocol {
    func loadImage(by url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
