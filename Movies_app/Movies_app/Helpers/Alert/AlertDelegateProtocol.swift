// AlertDelegateProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол алерта
protocol AlertDelegateProtocol: AnyObject {
    func showAlert(error: Error)
}
