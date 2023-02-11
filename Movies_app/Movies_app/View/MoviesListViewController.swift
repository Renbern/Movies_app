// MoviesListViewController.swift
// Copyright © A.Shchukin. All rights reserved.

import UIKit

/// Стартовый экран приложения
final class MoviesListViewController: UIViewController {
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
        static let alertTitle = "Внимание!"
        static let alertMessage = "Для входа в приложение введите ключ"
    }

    // MARK: - Private visual elements

    private let activityIndicatorView = UIActivityIndicatorView()
    private let tableView = UITableView()

    private var moviesListViewModel: MoviesListViewModelProtocol?

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

    // MARK: - Public properties

    var onMovieDetail: IntHandler?
    var listMoviesState: ListMovieStates = .initial {
        didSet {
            DispatchQueue.main.async {
                self.view.setNeedsLayout()
            }
        }
    }

    // MARK: - Initializer

    init(moviesListViewModel: MoviesListViewModelProtocol) {
        self.moviesListViewModel = moviesListViewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public properties

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupByStateCondition()
    }

    // MARK: - Private methods

    @objc private func changeMoviesListAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            obtainMovies(method: .topRated)
        case 1:
            obtainMovies(method: .popular)
        case 2:
            obtainMovies(method: .actual)
        default:
            return
        }
    }

    private func setupByStateCondition() {
        switch listMoviesState {
        case .initial:
            setupUI()
            activityIndicatorView.startAnimating()
            tableView.isHidden = true
        case .success:
            tableView.isHidden = false
            activityIndicatorView.isHidden = true
            activityIndicatorView.stopAnimating()
            tableView.reloadData()
        case let .failure(error):
            showAlert(error: error)
        }
    }

    private func keyChainAlert() {
        showAPIKeyAlert(
            title: Constants.alertTitle,
            message: Constants.alertMessage
        ) { [weak self] apiKey in
            guard let self = self else { return }
            self.moviesListViewModel?.getKeyChain()?.saveAPIKey(
                apiKey,
                forKey: GlobalConstants.apiKey
            )
        }
        tableView.reloadData()
    }

    private func setupActivityIndicatorConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupListMoviesStates() {
        moviesListViewModel?.listMoviesStates = { [weak self] state in
            self?.listMoviesState = state
        }
    }

    private func setupUI() {
        if moviesListViewModel?.getKeyChain()?.getAPIKey(GlobalConstants.apiKey) == "" {
            keyChainAlert()
        }
        setupListMoviesStates()
        title = Constants.screenTitle
        setupTableView()
        obtainMovies(method: .topRated)
        view.addSubview(selectTopRatedMoviesListButton)
        view.addSubview(selectPopularMoviesListButton)
        view.addSubview(selectLatestMoviesListButton)
        view.addSubview(activityIndicatorView)
        selectTopRatedMoviesListButton.translatesAutoresizingMaskIntoConstraints = false
        selectPopularMoviesListButton.translatesAutoresizingMaskIntoConstraints = false
        selectLatestMoviesListButton.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        showErrorAlert()
        showCoreDataErrorAlert()
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
        setupActivityIndicatorConstraints()
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

    private func obtainMovies(method: RequestType) {
        moviesListViewModel?.loadMoviesFromCoreData(category: method)
    }

    private func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: topRow, at: .top, animated: true)
    }

    private func showErrorAlert() {
        moviesListViewModel?.showErrorAlert = { [weak self] error in
            DispatchQueue.main.async {
                self?.showAlert(error: error)
            }
        }
    }

    private func showCoreDataErrorAlert() {
        moviesListViewModel?.showCoreDataAlert = { [weak self] error in
            DispatchQueue.main.async {
                self?.showAlert(error: error)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moviesListViewModel?.movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.movieCell, for: indexPath) as? MovieTableViewCell,
            let moviesListViewModel = moviesListViewModel
        else {
            return UITableViewCell()
        }
        cell.configure(index: indexPath.row, moviesListViewModel: moviesListViewModel)
        cell.alertDelegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = moviesListViewModel?.movies?[indexPath.row].movieId
        onMovieDetail?(Int(movieId ?? 0))
    }
}

/// Алерт делегат
extension MoviesListViewController: AlertDelegateProtocol {
    func showAlert(error: Error) {
        showAlert(title: Constants.error, message: error.localizedDescription, handler: nil)
    }

    func showAlert(error: String) {
        showAlert(title: Constants.error, message: error, handler: nil)
    }
}
