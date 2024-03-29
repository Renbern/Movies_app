// MoviesAppUITestsLaunchTests.swift
// Copyright © A.Shchukin. All rights reserved.

import XCTest

/// Тесты запуска
final class MoviesAppUITestsLaunchTests: XCTestCase {
    // MARK: - Public methods

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
