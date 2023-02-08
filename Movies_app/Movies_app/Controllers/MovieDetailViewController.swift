// MovieDetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран деталей фильма
final class MovieDetailViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        static let detailCell = "detailCell"
        static let errorTitle = "Error"
        enum Colors {
            static let red = "redMark"
            static let orange = "orangeMark"
            static let green = "greenMark"
            static let blue = "blueButton"
            static let gray = "grayForUI"
        }
    }

    // MARK: - Public properties

    var movieDetailViewModel: MovieDetailViewModelProtocol?

    // MARK: - Private visual component

    private let tableView = UITableView()

    // MARK: - Initializer

    init(movieDetailViewModel: MovieDetailViewModelProtocol) {
        self.movieDetailViewModel = movieDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private methods

    private func setupUI() {
        movieDetailViewModel?.fetchDetails()
        setupTableView()
        showErrorAlert()
        updateView()
    }

    private func updateView() {
        movieDetailViewModel?.updateView = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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

    private func showErrorAlert() {
        movieDetailViewModel?.showErrorAlert = { [weak self] error in
            DispatchQueue.main.async {
                self?.showAlert(error: error)
            }
        }
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
            let movieDetailViewModel = movieDetailViewModel
        else {
            return UITableViewCell()
        }
        cell.configure(index: indexPath.row, movieDetailViewModel: movieDetailViewModel)
        cell.alertDelegate = self
        return cell
    }
}

// MARK: - AlertDelegateProtocol

extension MovieDetailViewController: AlertDelegateProtocol {
    func showAlert(error: Error) {
        showAlert(title: Constants.errorTitle, message: error.localizedDescription, handler: nil)
    }
}
