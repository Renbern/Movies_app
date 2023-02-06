// MovieDetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран деталей фильма
final class MovieDetailViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let detailCell = "detailCell"

        enum Colors {
            static let red = "redMark"
            static let orange = "orangeMark"
            static let green = "greenMark"
            static let blue = "blueButton"
            static let gray = "grayForUI"
        }
    }

    // MARK: - Public properties

    var details: Details?
    var movieId: Int?

    // MARK: - Private properties

    private let sessionConfiguration = URLSessionConfiguration.default
    private let decoder = JSONDecoder()
    private let session = URLSession.shared
    private let tableView = UITableView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private methods

    private func setupUI() {
        obtainExactMovie()
        setupTableView()
    }

    private func obtainExactMovie() {
        guard let url =
            URL(
                string: "\(UrlRequest.baseURL)\(movieId ?? 0)\(UrlRequest.apiKey)\(UrlRequest.ruLanguage)"
            ) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            do {
                self.details = try JSONDecoder().decode(Details.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieDetailTableViewCell.self, forCellReuseIdentifier: Constants.detailCell)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.detailCell, for: indexPath) as? MovieDetailTableViewCell,
            let movie = details
        else {
            return UITableViewCell()
        }
        cell.setupCell(movie)
        return cell
    }
}
