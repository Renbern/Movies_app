// AlertDelegateProtocol.swift
// Copyright © A.Shchukin. All rights reserved.

import Foundation

/// Протокол алерта
protocol AlertDelegateProtocol: AnyObject {
    func showAlert(error: Error)
}
