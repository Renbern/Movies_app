// MoviesAppUITests.swift
// Copyright © A.Shchukin. All rights reserved.

import XCTest

/// Тесты пользовательского интерфейса
final class MoviesAppUITests: XCTestCase {
    // MARK: - Constants

    private enum UITestConstants {
        static let firstTestableMovie = "Побег из Шоушенка"
        static let secondTestableMovie = "Крёстный отец 2"
        static let thirdTestableMovie = "Аватар: Путь воды"
        static let navigationBackButton = "Movie"
        static let popularButton = "Популярное"
    }

    // MARK: - Public methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        app.swipeUp()
        app.tap()
        app.navigationBars.buttons[UITestConstants.navigationBackButton].tap()
        app.swipeDown()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
