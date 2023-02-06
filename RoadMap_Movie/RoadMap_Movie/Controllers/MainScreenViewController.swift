// MainScreenViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Стартовый экран приложения
final class MainScreenViewController: UIViewController {
    // MARK: - Constants

    private enum Constants {
        enum MovieSections {
            static let topRatedText = "Высокий рейтинг"
            static let popularText = "Популярное"
            static let actualText = "Скоро"
        }

        enum Colors {
            static let red = "redMark"
            static let orange = "orangeMark"
            static let green = "greenMark"
            static let blue = "blueButton"
            static let gray = "grayForUI"
            static let lightBlue = "lightBlue"
        }

        static let movieCell = "movieCell"
        static let error = "error"
        static let screenTitle = "Movie"
        static let detailScreenTitle = "Details"
        static let ruLanguage = "ru"
        static let enLanguage = "en"
    }

    // MARK: - Private visual elements

    private lazy var selectTopRatedMoviesListButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.MovieSections.topRatedText, for: .normal)
        button.tag = 0
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        button.backgroundColor = UIColor(named: Constants.Colors.blue)
        button.addTarget(self, action: #selector(changeMoviesListAction), for: .touchUpInside)
        return button
    }()

    private lazy var selectPopularMoviesListButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.MovieSections.popularText, for: .normal)
        button.tag = 1
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        button.backgroundColor = UIColor(named: Constants.Colors.blue)
        button.addTarget(self, action: #selector(changeMoviesListAction), for: .touchUpInside)
        return button
    }()

    private lazy var selectLatestMoviesListButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.MovieSections.actualText, for: .normal)
        button.tag = 2
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        button.backgroundColor = UIColor(named: Constants.Colors.blue)
        button.addTarget(self, action: #selector(changeMoviesListAction), for: .touchUpInside)
        return button
    }()

    private let tableView = UITableView()

    // MARK: - Private properties

    private let sessionConfiguration = URLSessionConfiguration.default
    private let decoder = JSONDecoder()
    private let session = URLSession.shared
    private var movies: Results?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private methods

    @objc private func changeMoviesListAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            obtainMovies(
                sectionUrl:
                "\(UrlRequest.baseURL)\(UrlRequest.topRated)\(UrlRequest.apiKey)\(UrlRequest.ruLanguage)"
            )
        case 1:
            obtainMovies(
                sectionUrl:
                "\(UrlRequest.baseURL)\(UrlRequest.popularURL)\(UrlRequest.apiKey)\(UrlRequest.ruLanguage)"
            )
        case 2:
            obtainMovies(
                sectionUrl:
                "\(UrlRequest.baseURL)\(UrlRequest.actualURL)\(UrlRequest.apiKey)\(UrlRequest.ruLanguage)"
            )
        default:
            return
        }
    }

    private func setupUI() {
        title = Constants.screenTitle
        setupTableView()
        obtainMovies(
            sectionUrl: UrlRequest.baseURL + UrlRequest.topRated + UrlRequest.apiKey + UrlRequest.ruLanguage
        )
        view.addSubview(selectTopRatedMoviesListButton)
        view.addSubview(selectPopularMoviesListButton)
        view.addSubview(selectLatestMoviesListButton)
        selectTopRatedMoviesListButton.translatesAutoresizingMaskIntoConstraints = false
        selectPopularMoviesListButton.translatesAutoresizingMaskIntoConstraints = false
        selectLatestMoviesListButton.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }

    private func setupSelectTopRatedMoviesListButtonConstraints() {
        NSLayoutConstraint.activate([
            selectTopRatedMoviesListButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectTopRatedMoviesListButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33),
            selectTopRatedMoviesListButton.heightAnchor.constraint(equalToConstant: 50),
            selectTopRatedMoviesListButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }

    private func setupSelectPopularMoviesListButtonConstraints() {
        NSLayoutConstraint.activate([
            selectPopularMoviesListButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33),
            selectPopularMoviesListButton.heightAnchor.constraint(equalToConstant: 50),
            selectPopularMoviesListButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            selectPopularMoviesListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupSelectLatestMoviesListButtonConstraints() {
        NSLayoutConstraint.activate([
            selectLatestMoviesListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectLatestMoviesListButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33),
            selectLatestMoviesListButton.heightAnchor.constraint(equalToConstant: 50),
            selectLatestMoviesListButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }

    private func setupConstraints() {
        setupSelectTopRatedMoviesListButtonConstraints()
        setupSelectPopularMoviesListButtonConstraints()
        setupSelectLatestMoviesListButtonConstraints()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: Constants.movieCell)
    }

    private func obtainMovies(sectionUrl: String) {
        guard let url =
            URL(
                string: sectionUrl
            ) else { return }
        URLSession.shared.fetchData(at: url) { result in
            switch result {
            case let .success(moviesAPI):
                self.movies = moviesAPI.self
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.scrollToTop()
                }
            case .failure:
                print(Constants.error)
            }
        }
    }

    private func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: topRow, at: .top, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies?.movies.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.movieCell, for: indexPath) as? MovieTableViewCell,
            let movie = movies?.movies[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.setupCell(movie)
        cell.setMarkColor(movie)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = movies?.movies[indexPath.row].id
        let detailsViewController = MovieDetailViewController()
        detailsViewController.movieId = movieId
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
