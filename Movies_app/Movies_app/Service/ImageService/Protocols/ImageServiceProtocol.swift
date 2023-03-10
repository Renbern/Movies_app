// ImageServiceProtocol.swift
// Copyright © A.Shchukin. All rights reserved.

import UIKit

/// Протокол получения изображений
protocol ImageServiceProtocol {
    func fetchImage(imageURLPath: String, completion: @escaping (Result<Data, Error>) -> Void)
}
