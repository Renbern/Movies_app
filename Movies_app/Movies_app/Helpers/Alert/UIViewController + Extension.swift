// UIViewController + Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

typealias VoidHandler = () -> ()
typealias IntHandler = (Int) -> (Void)
typealias ErrorHandler = (Error) -> (Void)

extension UIViewController {
    // MARK: - Constants

    private enum AlertConstants {
        static let okActionText = "Ok"
    }

    // MARK: - Public method

    func showAlert(
        title: String?,
        message: String?,
        handler: ((UIAlertAction) -> ())?
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertControllerAction = UIAlertAction(title: AlertConstants.okActionText, style: .default)
        alertController.addAction(alertControllerAction)
        present(alertController, animated: true)
    }

    typealias Closure = ((String) -> Void)?
    func showAPIKeyAlert(title: String?, message: String, handler: Closure) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertControllerAction = UIAlertAction(title: AlertConstants.okActionText, style: .default) { _ in
            let result = alertController.textFields?.first?.text ?? ""
            handler?(result)
        }
        alertController.addTextField()
        alertController.addAction(alertControllerAction)
        present(alertController, animated: true)
    }
}
